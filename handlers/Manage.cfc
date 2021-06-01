component output = "false" {

	property name = "ManageService" inject;

	function index (event, rc, prc) {
		abort
	}

	function build (event, rc, prc) {
		var res = ManageService.generateStaticContent(prc);
		// directoryCopy(source = expandPath(".") & "/dist", destination = "/static", recurse = true);

		return res;
	}

	function deploy (event, rc, prc) {
		var start = getTickCount();
		var res = ManageService.generateStaticContent(prc);
		// directoryCopy(source = expandPath(".") & "/dist", destination = "/static", recurse = true);
		// cfexecute( name="/blog/commit.sh", variable="out" );

		return "Build and Deploy completed in " & (getTickCount() - start ) & " ms";
	}


}