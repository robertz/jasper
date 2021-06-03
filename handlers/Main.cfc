component extends="coldbox.system.EventHandler" {

	property name = "PostService" inject;
	property name = "MarkdownService" inject = "Processor@cbmarkdown";
	property name = "jSoup" inject = "javaLoader:org.jsoup.Jsoup";

	function index( event, rc, prc ) {
		// var files = directoryList("posts/");
		prc['posts'] = PostService.list();
		prc['tagCloud'] = PostService.getTags();

		prc.headers.append({'property': "og:title", 'content': "#prc.meta.title#"});
		prc.headers.append({'property': "og:description", 'content': "#prc.meta.description#"});
		prc.headers.append({'property': "og:image", 'content': "https://static.kisdigital.com/images/backdrop.jpeg"});
		prc.headers.append({'name': "twitter:card", 'content': "summary_large_image"});
		prc.headers.append({'name': "twitter:title", 'content': "#prc.meta.title#"});
		prc.headers.append({'name': "twitter:description", 'content': "#prc.meta.description#"});
		prc.headers.append({'name': "twitter:image", 'content': "https://static.kisdigital.com/images/backdrop.jpeg"});

		event.setView( "main/index" );
	}

	function notfound (event, rc, prc) {
		event.setView( "main/404" );
	}

	function search (event, rc, prc) {
		var posts = PostService.list();
		var output = [];

		var id = 0;
		posts.each((post) => {
			output.append({
				"id": id,
				"slug": post.slug,
				"title": post.title,
				"description": post.description,
				"body": jSoup.parse(MarkdownService.toHTML(PostService.getMarkdown(slug = post.slug).markdown)).text(),
				"author": post.author
			});
			id++;
		});

		prc['docs'] = serializeJSON(output);

		event.setView( "main/search" );
	}


	/************************************** IMPLICIT ACTIONS *********************************************/

	function onAppInit( event, rc, prc ) {
	}

	function onRequestStart( event, rc, prc ) {
	}

	function onRequestEnd( event, rc, prc ) {
	}

	function onSessionStart( event, rc, prc ) {
	}

	function onSessionEnd( event, rc, prc ) {
		var sessionScope     = event.getValue( "sessionReference" );
		var applicationScope = event.getValue( "applicationReference" );
	}

	function onException( event, rc, prc ) {
		event.setHTTPHeader( statusCode = 500 );
		// Grab Exception From private request collection, placed by ColdBox Exception Handling
		var exception = prc.exception;
		// Place exception handler below:
	}

}
