import os, sys
cwd = os.path.dirname(__file__)
sys.path.insert(0, cwd)

import settings
os.chdir(cwd)

from bottle import route, default_app, static_file, template, debug, request, hook, redirect, error
import beaker.middleware
import sqlite3


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
	return template('home')

@route('/signup')
def signup_form():
	return template('signup')

@route('/process_signup', method='POST')
def signup():
	name = request.POST.get('name', '')
	email = request.POST.get('email', '')
	password = request.POST.get('password', '')
	password_confirm = request.POST.get('password_confirm', '')
	con = sqlite3.connect('cuneiform.sqlite3')
	cursor = con.cursor()
	cursor.execute('insert into users(name, email, password, date_joined) values(?, ?, ?, strftime("%s", "now"))', (name, email, password))
	userid = cursor.lastrowid
	con.commit()
	cursor.close()
	redirect('/thanks')

@route('/login')
def login():
	return template('login')

@route('/about')
def about():
	return template('about')

@route('/thanks')
def thanks():
	return template('signup_thanks')

@route('/static/<filename:path>')
def send_static(filename):
	return static_file(filename, root= cwd + '/static')

@error(404)
def error404(error):
	return template('404')

#application = default_app()
application = beaker.middleware.SessionMiddleware(default_app(), session_opts)
