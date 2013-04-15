<script type="text/javascript" src="/static/js/monocore.js"></script>
<script type="text/javascript" src="/static/js/monoctrl.js"></script>

<script type="text/javascript" src="/static/js/js-inflate.min.js"></script>
<script type="text/javascript" src="/static/js/js-unzip.min.js"></script>
<script type="text/javascript" src="/static/js/js-epub.min.js"></script>

<link rel="stylesheet" type="text/css" href="/static/css/monocore.css" />
<link rel="stylesheet" type="text/css" href="/static/css/monoctrl.css" /> /
<link rel="stylesheet" type="text/css" href="/static/css/reader.css" /> /
<br>
<br>
<br>

<div id="loader"><img class="ajax-loader" src="/static/img/loader.gif"></div>
<div id="learn" style="display:none"> <a id="learnButton" href="#" role="button" class="btn btn-primary learn" >Dictionary Reference</a></div>
<div id="reader"></div>
<input type="hidden" id="epub_location" value="/static/books/{{epub}}" />
<input type="hidden" id="hidLearn" value="" />

<div id="learnModal" class="modal hide fade" tabindex="-1" role="dialog" aria-labelledby="learnModalLabel" aria-hidden="true">
	<div class="modal-header">
		<button type="button" class="close" data-dismiss="modal" aria-hidden="true">x</button>
		<h3 id="myModalLabel">Dictionary Reference</h3>
	</div>
	<div class="modal-body">
		<div id="wordnet"></div>
	</div>
	<div class="modal-footer">
		<button class="btn" data-dismiss="modal" aria-hidden="true">Close</button>
	</div>
</div>

<div id="ImageModal" class="modal hide fade" tabindex="-1" role="dialog" aria-labelledby="imageModalLabel" aria-hidden="true">
	<div class="modal-header">
		<button type="button" class="close" data-dismiss="modal" aria-hidden="true">x</button>
		<h3 id="imageModalLabel">Dictionary Reference</h3>
	</div>
	<div class="modal-body">
		<div id="googleImage"></div>
	</div>
	<div class="modal-footer">
		<button class="btn" data-dismiss="modal" aria-hidden="true">Close</button>
	</div>
</div>

	
<script type="text/javascript" src="/static/js/reader.js"></script>
%rebase base title=title, session=session
