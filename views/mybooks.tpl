<!-- About Project members -->
<br />
<br />
<br />
<div class="container">
	<div class="row">
		%include sidemenu active_mybooks=active_mybooks
		<h1>My Books</h1>
		<div class="span8">
		%if books:
			<table class="table table-striped table-bordered table-condensed">
				<thead>
					<tr>
						<th>Book</th>
						<th>Author</th>
					</tr>
				</thead>
				<tbody>
					%for book in books:
						<tr><td><a href="demoreader?epub={{book[1]}}/{{book[2]}}">{{book[3]}}</a></td><td>{{book[4]}}</td></tr>
					%end
				</tbody>
			</table>
		%else:
			<h3 style="color:purple">You have no books. Please try uploading some books</h3>
			<a href="/upload" class="btn btn-primary">Upload</a>
		%end

		</div>
	</div>
</div>
%rebase base title="My Books", session=session, active_mybooks='active'
