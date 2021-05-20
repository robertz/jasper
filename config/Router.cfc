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


		// Conventions based routing
		route( ":handler/:action?" ).end();
	}

}
