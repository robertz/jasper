component {

	function configure() {
		// Set Full Rewrites
		setFullRewrites( true );

		route( "/post/:slug")
			.to( "post.get");

		route( "/page/:slug")
			.to( "page.get");

		route( "/tag/:tag")
			.to( "post.filterByTag");

		route( "/search")
			.to( "main.search");

		// Conventions based routing
		route( ":handler/:action?" ).end();
	}

}
