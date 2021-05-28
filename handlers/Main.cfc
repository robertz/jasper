component extends="coldbox.system.EventHandler" {

	property name = "PostService" inject;

	function index( event, rc, prc ) {
		// var files = directoryList("posts/");
		prc['posts'] = PostService.list();
		prc['tagCloud'] = PostService.getTags();

		event.setView( "main/index" );
	}

	function notfound (event, rc, prc) {
		event.setView( "main/404" );
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
