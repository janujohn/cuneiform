<!DOCTYPE html>
<html lang="en">
	<head>
		<!-- Meta Data -->
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
		<meta name="viewport" content="width=device-width, initial-scale=1.0">
		<meta name="author" content="Johnsi and Tamil">
		<meta name="copyright" content="&copy;2012 Janu & Tamil" />

		<!-- CSS -->
		<link rel="stylesheet" type="text/css" href="/static/css/bootstrap.min.css" >
		<link rel="stylesheet" type="text/css" href="/static/css/cuneiform.css" />

		<!-- Javascript -->
		<script src="/static/js/jquery-1.9.1.min.js" type="text/javascript"></script>
		<script src="/static/js/bootstrap.min.js" type="text/javascript"></script>

		<!-- Le HTML5 shim, for IE6-8 support of HTML5 elements -->
		<!--[if lt IE 9]>
		<script src="http://html5shim.googlecode.com/svn/trunk/html5.js"></script>
		<![endif]-->

		<title>{{title or "No Title"}}</title>
	</head>

	<body>
		<!-- Navigation Bar -->
		<div class="navbar navbar-inverse navbar-fixed-top">
			<div class="navbar-inner">
				<div class="container">
					<button type="button" class="btn btn-navbar" data-toggle="collapse" data-target=".nav-collapse">
						<span class="icon-bar"></span>
						<span class="icon-bar"></span>
						<span class="icon-bar"></span>
					</button>
					<a class="brand" href="/">Cuneiform</a>

					<div class="nav-collapse collapse">
						<ul class="nav">
							<li class="{{get('active_home', '')}}"><a href="home">Home</a></li>
							<li class="{{get('active_about', '')}}"><a href="about">About</a></li>
							<li class="{{get('active_demo', '')}}"><a href="demo">Demo</a></li>
						</ul>

						<ul class="nav secondary-nav pull-right">
							%if 'userid' not in session:
							<li class="{{get('active_signup', '')}}"><a href="signup">Sign Up</a></li>
							<li class="{{get('active_login', '')}}"><a href="login"><i class="icon-lock icon-white"></i>&nbsp;&nbsp;Login</a></li>
							%end

							%if 'userid' in session:
							<li class="{{get('active_mybooks', '')}}"><a href="/mybooks">My Books</a></li>
							<li style="color:#fff;padding:10px 15px;"><span>{{session['username']}}</span><span>&nbsp;&nbsp; [ <a href="/logout">logout</a> ]</span></li>
							%end
						</ul>
					</div>

				</div>
			</div>
		</div>

		%include

		<!-- footer -->
		<footer class="footer" >
			<div class="container">
				<p class="muted credit">Powered by <a href="http://www.python.org/">python</a>, <a href="http://bottlepy.org">bottle</a>, <a href="http://twitter.github.com/bootstrap/">bootstrap</a>, <a href="http://www.sqlite.org/">sqlite</a>, <a href="https://github.com/joseph/monocle">monocle</a></p>
				<p class="muted credit">Designed and developed By TamilSelvi and JohnsiRaani</p>
				<p class="muted credit">Guided By Mrs R.Karuppathal</p>
				<p class="muted credit">&copy; Copyright 2013</p>
			</div>
		</footer>
	</body>
</html>
