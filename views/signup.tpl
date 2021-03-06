<script type="text/javascript" src="/static/js/validate.js"></script>
<br><br><br>
<div class="container">
<form id="signup" class="form-horizontal" action='/signup' method="POST">
  <fieldset>
    <div id="legend">
      <legend class="">Sign Up</legend>
    </div>

    <div class="control-group">
      <!-- E-mail -->
      <label class="control-label" for="email">Your Name</label>
      <div class="controls">
        <input required type="text" id="name" name="name" placeholder="Your Name" class="input-xlarge">
      </div>
    </div>

    <div class="control-group">
      <!-- E-mail -->
      <label class="control-label" for="email">E-mail</label>
      <div class="controls">
        <input required type="email" id="email" name="email" placeholder="Your Email address" class="input-xlarge">
      </div>
    </div>

    <div class="control-group">
      <!-- Password-->
      <label class="control-label" for="password">Password</label>
      <div class="controls">
        <input required type="password" id="password" name="password" placeholder="Choose a password" class="input-xlarge">
      </div>
    </div>

    <div class="control-group">
      <!-- Password -->
      <label class="control-label"  for="password_confirm">Password (Confirm)</label>
      <div class="controls">
        <input required data-validation-matches-match="password"	data-validation-matches-message="Passwords must match" type="password" id="password_confirm" name="password_confirm" placeholder="Confirm your password" class="input-xlarge">
      </div>
    </div>

    <div class="control-group">
      <!-- Button -->
      <div class="controls">
        <button class="btn btn-primary">Sign UP Now!</button>
      </div>
    </div>
  </fieldset>
</form>
</div>
<script type="text/javascript">
	$(function () {
		$("input,select,textarea").not("[type=submit]").jqBootstrapValidation({
			preventSubmit:true,
		}); 
	});
</script>
%rebase base title="Signup Now", active_signup='active', session=session
