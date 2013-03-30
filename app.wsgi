import os, sys
cwd = os.path.dirname(__file__)
sys.path.insert(0, cwd)

import settings
os.chdir(cwd)

from bottle import route, default_app, static_file, template, debug

# Disable this once stable
debug(True)

@route('/home')
@route('/')
def home():
	return template('home')

@route('/login')
def login():
	return template('login')

@route('/about')
def about():
	return template('about')

@route('/static/<filename:path>')
def send_static(filename):
	return static_file(filename, root= cwd + '/static')

application = default_app()


