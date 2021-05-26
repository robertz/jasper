<cfoutput>
<!doctype html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
	<title>#prc.meta.title#</title>
	<meta name="description" content="#prc.meta.description#">
    <meta name="author" content="#prc.meta.author#">
	<meta name="twitter:widgets:theme" content="light">
	<meta name="twitter:widgets:border-color" content="##55acee">
	<!--- <base href="#event.getHTMLBaseURL()#" /> --->
	<cfloop array="#prc.headers#" index="header">
		<cfif header.keyExists("property")>
			<meta property="#header.property#" content="#header.content#" />
		<cfelse>
			<meta name="#header.name#" content="#header.content#" />
		</cfif>
	</cfloop>
	<link rel="stylesheet" href="https://unpkg.com/bootstrap@4.6.0/dist/css/bootstrap.min.css" crossorigin="anonymous">
	<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/prism/1.23.0/themes/prism-okaidia.min.css" integrity="sha512-mIs9kKbaw6JZFfSuo+MovjU+Ntggfoj8RwAmJbVXQ5mkAX5LlgETQEweFPI18humSPHymTb5iikEOKWF7I8ncQ==" crossorigin="anonymous" referrerpolicy="no-referrer" />
	<link rel="stylesheet" href="/assets/css/site.css?v=#createUUID()#">
</head>
<body style="padding-top: 70px;">
	<nav class="navbar fixed-top navbar-expand-lg navbar-dark bg-dark">
		<div class="container">
			<a class="navbar-brand" href="/">Jasper</a>
			<button class="navbar-toggler" type="button" data-toggle="collapse" data-target="##navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
				<span class="navbar-toggler-icon"></span>
			</button>
			<div class="collapse navbar-collapse" id="navbarSupportedContent">
				<ul class="navbar-nav mr-auto">
					<li class="nav-item active">
						<a class="nav-link" href="/tag/code#prc.buildExt#">Code</a>
					</li>
					<li class="nav-item active">
						<a class="nav-link" href="/tag/misc#prc.buildExt#">Misc</a>
					</li>
					<li class="nav-item active">
						<a class="nav-link" href="/page/readme#prc.buildExt#">Readme</a>
					</li>
				</ul>
			</div>
		</div>
	</nav>

	<!---Container And Views --->
	<div class="container">#renderView()#</div>

	<footer class="border-top py-3 mt-5">
		<div class="container">
			<small>KISDigital.com&copy; 2020 - #dateFormat(now(), "yyyy")#</small>
		</div>
	</footer>

	<!---js --->
	<!-- jQuery first, then Popper.js, then Bootstrap JS -->
    <script src="https://code.jquery.com/jquery-3.4.1.slim.min.js" integrity="sha384-J6qa4849blE2+poT4WnyKhv5vZF5SrPo0iEjwBvKU7imGFAV0wwj1yYfoRSJoZ+n" crossorigin="anonymous"></script>
    <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.0/dist/umd/popper.min.js" integrity="sha384-Q6E9RHvbIyZFJoft+2mJbHaEWldlvI9IOYy5n3zV9zzTtmI3UksdQRVvoxMfooAo" crossorigin="anonymous"></script>
    <script src="https://unpkg.com/bootstrap@4.6.0/dist/js/bootstrap.min.js" crossorigin="anonymous"></script>
	<script type="text/javascript" src="//cdn.jsdelivr.net/gh/dkern/jquery.lazy@1.7.10/jquery.lazy.min.js"></script>
	<script type="text/javascript" src="//cdn.jsdelivr.net/gh/dkern/jquery.lazy@1.7.10/jquery.lazy.plugins.min.js"></script>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/prism/1.23.0/prism.min.js" integrity="sha512-YBk7HhgDZvBxmtOfUdvX0z8IH2d10Hp3aEygaMNhtF8fSOvBZ16D/1bXZTJV6ndk/L/DlXxYStP8jrF77v2MIg==" crossorigin="anonymous" referrerpolicy="no-referrer"></script>
	<script>
		$(function($) {
			$('.lazy img').lazy()
		})
	</script>
</body>
</html>
</cfoutput>
