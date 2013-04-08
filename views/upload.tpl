<br />
<br />
<br />
<div class="container">
	<div class="row">
		%include sidemenu active_upload=active_upload
		<div class="well span8">
<form method="POST" action="/upload" enctype="multipart/form-data">
<fieldset>
	<legend>Upload Ebook</legend>
<div class="control-group">
	   %if 'error' in globals():
	   <span class="label label-important">{{error}}</span> 
	   <br>
	   <br>
	   %end
	<label class="control-label" for="book">Upload Epub</label>
	<div class="controls">
		<input id="book" name="book" type="file" />
	</div>
	<div class="controls">
		<br>
		<button type="submit" class="btn btn-success">Upload Book</button>
	</div>

</fieldset>
</form>
		</div>
	</div>
</div>
%rebase base title="Upload Ebook", session=session
