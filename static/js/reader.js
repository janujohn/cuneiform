Monocle.Events.listen(window, 'load', initFn);

function initFn() {
	var epub = 'piedpiper.epub'
	var epubUrl;
	epubUrl =  epub;
	ePub.open(epubUrl, cb_book);

	function cb_book(book) {

		var fnmeta = function(key) {
			return {
				title: book.title,
				creator: book.author
			}[key];
		}

		var comp = {};
		var components = [];
		for(var i=0;i<book.contents.length;i++) {
			var href = book.contents[i].name;
			comp[href] = book.contentsByFile[href].content();
			components[i] = href;
		}

		var fncomponent = function(componentId) {
			return comp[componentId];
		}

		var fncomponents = function() {
			return components;
		}

		var toc = [];
		for(var i=0;i<book.toc.length;i++) {
			toc[i] = { title: book.toc[i].title, src: book.toc[i].fileName };
		}
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
/*
		Monocle.Reader('reader', bookData, {}, function (reader) {
			//reader.moveTo({ page: 3 });
		});
*/


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
              {
                start: function (evt) {
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
            function (evt) { chapterTitle.update(evt.m.page); }
          );


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
        }
      );







	}
}
