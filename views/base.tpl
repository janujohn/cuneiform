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
							<li><a href="home">Home</a></li>
							<li><a href="about">About</a></li>
							<li><a href="login">Login</a></li>
						</ul>
					</div>
				</div>
			</div>
		</div>

		<div class="container">
		%include
		</div>

		<!-- footer -->
		<div class="footer" style="padding-top:15px;margin-top:20px;background-color:#ddd">
			<div class="container">
				<div class="row">
					<div class="span5"></div>  
						<p class="muted credit">Guided By <a>Mrs R.Karuppathal</a></br>
							<div class="row">
								<div class="span5"></div>
								<p class="muted credit">Submitted By <a>N.TamilSelvi and M.JohnsiRaani</a></p>
							</div>
						</p>
					</div>
				</div>
			</div>
		</div>
	</body>
</html>
