<br />
<br />
<br />
<div class="container">
	<div class="row">
		%include sidemenu active_upload=active_upload
		<div class="well span8">
<fieldset>
	<legend>Upload Ebook</legend>
<div class="control-group">
	<label class="control-label" for="book">Upload Epub</label>
	<div class="controls">
		<input id="book" name="book" type="file" />
	</div>
	<div class="controls">
		<br>
		<button class="btn btn-success">Upload Book</button>
	</div>

</fieldset>

		</div>
	</div>
</div>
%rebase base title="Upload Ebook", session=session
