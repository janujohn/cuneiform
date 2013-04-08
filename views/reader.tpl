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
<div id="reader"></div>
<input type="hidden" id="epub_location" value="/static/books/{{epub}}" />
	
<script type="text/javascript" src="/static/js/reader.js"></script>
%rebase base title=title, session=session
