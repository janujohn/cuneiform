import os, sys
cwd = os.path.dirname(__file__)
sys.path.insert(0, cwd)

import settings
os.chdir(cwd)

from bottle import route, default_app, static_file, template, debug, request, hook
import beaker.middleware


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
def signup():
	return template('signup')

@route('/login')
def login():
	return template('login')

@route('/about')
def about():
	return template('about')

@route('/static/<filename:path>')
def send_static(filename):
	return static_file(filename, root= cwd + '/static')

#application = default_app()
application = beaker.middleware.SessionMiddleware(default_app(), session_opts)
