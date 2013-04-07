	<script type="text/javascript" src="/static/js/validate.js"></script>
	   <br>
	   <br>
	   <br>
	   <br>
      <form class="form-signin" style="margin-top:70px" method="POST" id="login_form" action="/login">
	   %if 'error' in globals():
	   <span class="label label-important">{{error}}</span> 
	   %end
        <h2 class="form-signin-heading">Please sign in</h2>

		<div class="controls">
			<input required id="email" name="email" type="text" class="input-block-level" placeholder="Email address">
		</div>
		<div class="controls">
			<input required id="password" name="password" type="password" class="input-block-level" placeholder="Password">
		</div>
		<div><button class="btn btn-large btn-primary" type="submit"><i class="icon-lock icon-white"></i> Sign in</button>&nbsp;&nbsp;&nbsp;&nbsp;New user? <a href="/signup">Sign Up</a> now!</span></div>
      </form>
     </div> <!-- /container -->
<div style="margin-bottom:60px"></div>
<script type="text/javascript">
	$(function () {
		$("input,select,textarea").not("[type=submit]").jqBootstrapValidation({
			preventSubmit:true,
		}); 
	});
</script>
%rebase base title="Please login", active_login='active', session=session
