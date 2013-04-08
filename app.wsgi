import os, sys
cwd = os.path.dirname(__file__)
sys.path.insert(0, cwd)

import settings
os.chdir(cwd)

from bottle import route, default_app, static_file, template, debug, request, hook, redirect, error
import beaker.middleware
import sqlite3
import hashlib, time, epub

session_opts = {
	'session.type': 'file',
	'session.data_dir': './session/',
	'session.auto': True,
}

# Disable this once stable
debug(True)

# set beaker session in request.session
@hook('before_request')
def setup_request():
	request.session = request.environ['beaker.session']

@route('/home')
@route('/')
def home():
	return template('home', session=request.session)

@route('/signup', method=['GET','POST'])
def signup():
	if request.method=='POST':
		name = request.POST.get('name', '').strip()
		email = request.POST.get('email', '').strip()
		password = request.POST.get('password', '').strip()
		password_confirm = request.POST.get('password_confirm', '').strip()
		con = sqlite3.connect('cuneiform.sqlite3')
		cursor = con.cursor()
		cursor.execute('insert into users(name, email, password, date_joined) values(?, ?, ?, strftime("%s", "now"))', (name, email, password))
		userid = cursor.lastrowid
		con.commit()
		cursor.close()
		redirect('/thanks')
	return template('signup', session=request.session)

@route('/login', method=['GET', 'POST'])
def login():
	if request.method=="POST":
		email = request.POST.get('email', '').strip()
		password = request.POST.get('password', '').strip()
		con = sqlite3.connect('cuneiform.sqlite3')
		c = con.cursor()
		c.execute('select * from users where email=? and password=?', (email, password))
		result = c.fetchone()
		if not result:
			return template('login', error='User name or password is wrong. Please try again', session=request.session)
		else:
			signin_user(result)
			redirect('/mybooks')
	return template('login', session=request.session)

@route('/logout')
def logout():
	request.session.delete()
	redirect('/home')

def signin_user(user_data):
	request.session['userid'] = user_data[0]
	request.session['username'] = user_data[1]
	request.session['email'] = user_data[2]
	request.session['joined_date'] = user_data[4]

@route('/demo')
def demo():
	return template('demo', session=request.session)

@route('/mybooks')
def mybooks():
	if 'userid' not in request.session:
		redirect('/login')

	con = sqlite3.connect('cuneiform.sqlite3')
	c = con.cursor()
	c.execute('select * from books where userid=? and is_active=1 ', (request.session['userid'],))
	books = c.fetchall()
	return template('mybooks', session=request.session, active_mybooks='active', books=books)

@route('/upload', method=['GET', 'POST'])
def upload():
	if 'userid' not in request.session:
		redirect('/login')
	error = ''
	if request.method=='POST':
		#do something
		upload =  request.files.get('book')
		name, ext = os.path.splitext(upload.filename)
		if ext.lower()=='.epub':
			# write it to books dir
			save_path = get_book_save_path(request.session['userid'], upload.filename)
			book_path = '/'.join(save_path)
			with open(book_path, 'w') as save_file:
				save_file.write(upload.file.read())

			book = epub.open_epub(book_path)
			title = str(book.opf.metadata.titles[0][0])
			author = str(book.opf.metadata.creators[0][0])

			con = sqlite3.connect('cuneiform.sqlite3')
			cursor = con.cursor()
			cursor.execute('insert into books(userid, filename, title, author, is_cover, is_active, date) values(?, ?, ?, ?, ?, ?, strftime("%s", "now"))', (request.session['userid'], save_path[1], title, author, 0, 1))
			bookid = cursor.lastrowid
			con.commit()
			cursor.close()
			redirect('/mybooks')

		else:
			error = "Error! Please upload only EPub format file"
	return template('upload', session=request.session, active_upload='active', error=error)

def get_book_save_path(userid, filename):
	upload_dir = settings.app_dir + '/static/books/' + str(userid)
	if not os.path.exists(upload_dir):
		os.makedirs(upload_dir)
	filename = hashlib.sha1(str(userid) + filename + str(time.time())).hexdigest()
	return [upload_dir, filename]

@route('/about')
def about():
	return template('about', session=request.session)

@route('/thanks')
def thanks():
	return template('signup_thanks', session=request.session)

@route('/demoreader')
def demoreader():
	epub = request.GET.get('epub', '').strip()
	con = sqlite3.connect('cuneiform.sqlite3')
	c = con.cursor()
	c.execute('select title from books where filename=?', (epub.split('/')[1],))
	title = c.fetchone()[0]
	return template('reader', session=request.session, epub=epub, title=title)

@route('/static/<filename:path>')
def send_static(filename):
	return static_file(filename, root= cwd + '/static')

@error(404)
def error404(error):
	return template('404', session={})

#application = default_app()
application = beaker.middleware.SessionMiddleware(default_app(), session_opts)
