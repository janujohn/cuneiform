<br><br><br>
<div class="container">
<form class="form-horizontal" action='/process_signup' method="POST">
  <fieldset>
    <div id="legend">
      <legend class="">Sign Up</legend>
    </div>

    <div class="control-group">
      <!-- E-mail -->
      <label class="control-label" for="email">E-mail</label>
      <div class="controls">
        <input type="text" id="email" name="email" placeholder="Your Email address" class="input-xlarge">
      </div>
    </div>

    <div class="control-group">
      <!-- Password-->
      <label class="control-label" for="password">Password</label>
      <div class="controls">
        <input type="password" id="password" name="password" placeholder="Choose a password" class="input-xlarge">
      </div>
    </div>

    <div class="control-group">
      <!-- Password -->
      <label class="control-label"  for="password_confirm">Password (Confirm)</label>
      <div class="controls">
        <input type="password" id="password_confirm" name="password_confirm" placeholder="Confirm your password" class="input-xlarge">
      </div>
    </div>

    <div class="control-group">
      <!-- Button -->
      <div class="controls">
        <button class="btn btn-success">Sign UP Now!</button>
      </div>
    </div>
  </fieldset>
</form>
</div>
%rebase base title="Signup Now", active_signup='active'
