Monocle.Events.listen(window, 'load', initFn);

function initFn() {
	$('footer').css('display', 'none');
	var epub = $('#epub_location').val()

	var client = new XMLHttpRequest();

	client.onreadystatechange = function () {
		if (client.readyState == 4 && client.status == 200) {
			book = new JSEpub(client.responseText);
			book.processInSteps(function(step, extras) {
				if (step === 5) {cb_book(book);}
			});
		} else if (client.readyState == 4 && client.status < 400 && client.status > 299) {
			alert('Book could not be found');
		} else if (client.readyState == 4) {
			alert('Error getting book');
		}
	};
	client.overrideMimeType('text/plain; charset=x-user-defined');
	client.open("GET", epub);
	client.send(null);
	return;

	function cb_book(book) {
		var fnmeta = function(key) {
			return {
				title: book.opf.metadata['dc:title']['_text'],
				creator: book.opf.metadata['dc:creator']['_text']
			}[key];
		}

	var comp = {};
	var components = [];
	for(var i=0;i<book.opf.spine.length;i++) {
		var spineName = book.opf.spine[i]
		href = book.opf.manifest[spineName]['href']
		var doc = book.files[href];
		var html = new XMLSerializer().serializeToString(doc);

		comp[href] = html
		components[i] = href;
	}

	var fncomponent = function(componentId) {
		return comp[componentId];
	}

	var fncomponents = function() {
		return components;
	}
	var toc=[]
	/*var toc = [];
	for(var i=0;i<book.toc.length;i++) {
	toc[i] = { title: book.toc[i].title, src: book.toc[i].fileName };
	}*/
		var fncontents = function() {
	return toc;
	}

	bookData = {
		getComponents: fncomponents,
		getContents: fncontents,
		getComponent: fncomponent,
		getMetaData: fnmeta
	}


	var readerOptions = {};

	/* PLACE SAVER */
	var bkTitle = bookData.getMetaData('title');
	var placeSaver = new Monocle.Controls.PlaceSaver(bkTitle);
	readerOptions.place = placeSaver.savedPlace();
	readerOptions.panels = Monocle.Panels.Marginal;
	readerOptions.stylesheet = "body { " + "color: #210;" + "font-family: Palatino, Georgia, serif;" +	"}";

	window.reader = Monocle.Reader(
		'reader',
		bookData,
		readerOptions,
		function(reader) {
			reader.addControl(placeSaver, 'invisible');

			// SPINNER
			var spinner = Monocle.Controls.Spinner(reader);
			reader.addControl(spinner, 'page', { hidden: true });
			spinner.listenForUsualDelays('reader');

					// Hide loader after book loaded
			Monocle.Events.listen('reader', 'monocle:loaded', function(){
				$('#loader').css('display', 'none')
				$('iframe').each(function(i,e){
					e.contentDocument.onmouseup = getSelectionText;
				})
			});

			// Because the 'reader' element changes size on window resize. we should notify it of this event.
			Monocle.Events.listen(
				window,
				'resize',
				function () { window.reader.resized() }
			);

			// MAGNIFIER CONTROL
			var magnifier = new Monocle.Controls.Magnifier(reader);
			reader.addControl(magnifier, 'page');

			// BOOK TITLE RUNNING HEAD
			var bookTitle = {}
			bookTitle.contentsMenu = Monocle.Controls.Contents(reader);
			reader.addControl(bookTitle.contentsMenu, 'popover', { hidden: true });
			bookTitle.createControlElements = function () {
				var cntr = document.createElement('div');
				cntr.className = "bookTitle";
				var runner = document.createElement('div');
				runner.className = "runner";
				runner.innerHTML = reader.getBook().getMetaData('title');
				cntr.appendChild(runner);

				Monocle.Events.listenForContact(
					cntr,
					{start: function (evt) {
						if (evt.preventDefault) {
							evt.stopPropagation();
							evt.preventDefault();
						} else {
							evt.returnValue = false;
						}
						reader.showControl(bookTitle.contentsMenu);
						}
					}
				);

				return cntr;
			}
			reader.addControl(bookTitle, 'page');


			// CHAPTER TITLE RUNNING HEAD
			var chapterTitle = {
				runners: [],
				createControlElements: function (page) {
					var cntr = document.createElement('div');
					cntr.className = "chapterTitle";
					var runner = document.createElement('div');
					runner.className = "runner";
					cntr.appendChild(runner);
					this.runners.push(runner);
					this.update(page);
					return cntr;
				},
				update: function (page) {
					var place = reader.getPlace(page);
					if (place) {
						this.runners[page.m.pageIndex].innerHTML = place.chapterTitle();
					}
				}
			}
			reader.addControl(chapterTitle, 'page');
			reader.listen(
				'monocle:pagechange',
				function (evt) {
//					$('iframe')[1].contentDocument.onmouseup = getSelectionText; 
//					if (!document.all) $('iframe')[1].contentDocument.captureEvents(Event.MOUSEUP);


					chapterTitle.update(evt.m.page); }
			);
/*
reader.listen(
'monocle:turn',
function(evt) {
	$('iframe')[1].contentDocument.onmouseup = getSelectionText; 
	if (!document.all) $('iframe')[1].contentDocument.captureEvents(Event.MOUSEUP);
});
*/
			// PAGE NUMBER RUNNING HEAD 
			var pageNumber = {
				runners: [],
				createControlElements: function (page) {
					var cntr = document.createElement('div');
					cntr.className = "pageNumber";
					var runner = document.createElement('div');
					runner.className = "runner";
					cntr.appendChild(runner);
					this.runners.push(runner);
					this.update(page, page.m.place.pageNumber());
					return cntr;
				},
				update: function (page, pageNumber) {
					if (pageNumber) {
						this.runners[page.m.pageIndex].innerHTML = pageNumber;
					}
				}
			}
			reader.addControl(pageNumber, 'page');
			reader.listen(
				'monocle:pagechange',
				function (evt) {
					pageNumber.update(evt.m.page, evt.m.pageNumber);
				}
			);

			// Scrubber 
			var scrubber = new Monocle.Controls.Scrubber(reader);
			reader.addControl(scrubber, 'popover', { hidden: true });
			var showFn = function (evt) {
				evt.stopPropagation();
				reader.showControl(scrubber);
				scrubber.updateNeedles();
			}
			for (var i = 0; i < chapterTitle.runners.length; ++i) {
				Monocle.Events.listenForContact(
					chapterTitle.runners[i].parentNode,
					{ start: showFn }
				);
				Monocle.Events.listenForContact(
					pageNumber.runners[i].parentNode,
					{ start: showFn }
				);
			}
		});
	}
}
var t = '';
function getSelectionText(e) {
	t = (document.all) ? $('iframe')[1].contentDocument.selection.createRange().text : $('iframe')[1].contentDocument.getSelection();
	if(t=='') {
		
	t = (document.all) ? $('iframe')[0].contentDocument.selection.createRange().text : $('iframe')[0].contentDocument.getSelection();
		}
	if(t!='') {
		$('#learn').css('display', 'block')
		$('#hidLearn').val(t);
	}
	else {
		$('#learn').css('display', 'none')
		$('#hidLearn').val('');
	}
}

function getMeaning(element) {
	word = $(element).attr('data-word')
	if($(element).attr('data-meaning') == '') {
		$.getJSON('/ajax/get_meaning?word='+word, function(data){
			$(element).attr('data-meaning', data['web_definition']['webDefinitions'][0])

			$(element).popover({
				'title' : 'Definition for "<b>'+word+'</b>":',
				'content': data['web_definition']['webDefinitions'][0],
				'html': true,
				'placement': 'bottom'
				});
			$(element).popover('show');

		});
	}
}

$(document).ready(function(){
	$('#learnButton').click(function(){

		data = {'text': $('#hidLearn').val()};
		var url = '/ajax/learn';
		$.ajax({
			dataType: "json",
			url: url,
			data: data,
			type: 'POST',
			success: function(data){
				var table = '<table class="table table-striped table-bordered table-condensed">';
				if(data['error'] == 'false') {
					for(var i=0;i<data['words'].length;i++) {
						table += '<tr>'
						table += '<td><a href="#">'+data['words'][i]+'</a></td>'
						table += '<td><a onclick="getMeaning(this)" data-meaning="" class="btn" data-word="'+data['words'][i]+'" >Meaning</a></td>'
						table += '<td><a onclick="getImage(\''+data['words'][i]+'\')"><img src="/static/img/googleIcon.gif"></a></td>'
						
						table += '</tr>'
					}
					table += '</table>'
					$('#wordnet').html(table)
					$('#learnModal').modal();
				}
			}
		});
	});
});

function getImage(word) {
	url = 'https://ajax.googleapis.com/ajax/services/search/images?v=1.0&callback=processImage&q=' + word;
	$.ajax({
		url: url,
		dataType: 'jsonp',
		jsonpCallback: processImage
	});
}

function processImage(data) {
	if(data) {
		var list = '<ul class="thumbnails">';
		for(var i=0;i<data['responseData']['results'].length;i++) {
			list += '<li class="span3"><div class="thumbnail"><img height="260" src="'+data['responseData']['results'][i]['url']+'" /></div></li>';
		}
		list += '</ul>';
		$('#googleImage').html(list);
		$('#ImageModal').modal();
	}
}
