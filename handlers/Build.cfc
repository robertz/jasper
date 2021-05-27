component {

	property name = "PostService" inject;
	property name = "PageService" inject;

	function index (event, rc, prc) {
		var tags = ["code", "misc"];
		if(getSetting("environment") != "development") abort;
		directoryDelete(path = expandPath(".") & "/dist", recurse = true);
		directoryCreate(path = expandPath(".") & "/dist", ignoreExists = true);
		directoryCreate(path = expandPath(".") & "/dist/post", ignoreExists = true);
		directoryCreate(path = expandPath(".") & "/dist/page", ignoreExists = true);
		directoryCreate(path = expandPath(".") & "/dist/tag", ignoreExists = true);

		// move static assets
		directoryCopy(source = expandPath(".") & "/assets", destination = expandPath(".") & "/dist/assets", recurse = true);
		cfhttp(url = "127.0.0.1:" & cgi.SERVER_PORT & "/?build=true");
		fileWrite(expandPath(".") & "/dist/index.html", cfhttp.fileContent);

		// Generate posts
		var posts = PostService.list();
		posts.each((post) => {
			cfhttp(url = "127.0.0.1:" & cgi.SERVER_PORT & "/post/" & post.slug & "?build=true", result = "_" &lcase(hash(post.slug)).replace("-", "", "all"));
			fileWrite(expandPath(".") & "/dist/post/" & post.slug & ".html", variables["_" & lcase(hash(post.slug)).replace("-", "", "all")].fileContent);
		}, true);

		// Generate pages
		var pages = PageService.list();
		pages.each((page) => {
			cfhttp(url = "127.0.0.1:" & cgi.SERVER_PORT & "/page/" & page.slug & "?build=true", result = "_" &lcase(hash(page.slug)).replace("-", "", "all"));
			fileWrite(expandPath(".") & "/dist/page/" & page.slug & ".html", variables["_" & lcase(hash(page.slug)).replace("-", "", "all")].fileContent);
		}, true);

		// Generate Tags
		tags.each((tag) => {
			cfhttp(url = "127.0.0.1:" & cgi.SERVER_PORT & "/tag/" & tag & "?build=true", result = "_" &lcase(hash(tag)).replace("-", "", "all"));
			fileWrite(expandPath(".") & "/dist/tag/" & tag & ".html", variables["_" & lcase(hash(tag)).replace("-", "", "all")].fileContent);
		}, true);

		return true;
	}

}