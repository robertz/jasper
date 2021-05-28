component {

	property name = "PostService" inject;
	property name = "PageService" inject;

	function index (event, rc, prc) {

		if(getSetting("environment") != "development") abort;

		var start = getTickCount();
		var generated = 0;

		// ColdBox handlers generate pages and where to write the file
		var contentPages = [
			{ act: "main.index", file: "index.html" }
		];

		var tags = ["code", "misc"]; // build these tag pages

		directoryDelete(path = expandPath(".") & "/dist/assets", recurse = true);
		directoryDelete(path = expandPath(".") & "/dist/post", recurse = true);
		directoryDelete(path = expandPath(".") & "/dist/page", recurse = true);
		directoryDelete(path = expandPath(".") & "/dist/tag", recurse = true);

		directoryCreate(path = expandPath(".") & "/dist/post", ignoreExists = true);
		directoryCreate(path = expandPath(".") & "/dist/page", ignoreExists = true);
		directoryCreate(path = expandPath(".") & "/dist/tag", ignoreExists = true);

		// move static assets
		directoryCopy(source = expandPath(".") & "/assets", destination = expandPath(".") & "/dist/assets", recurse = true);

		contentPages.each((page) => {
			cfhttp(url = "127.0.0.1:" & cgi.SERVER_PORT & "/" & page.act, result = page.act.replace(".", "_", "all"));
			fileWrite(expandPath(".") & "/dist/" & page.file, variables[page.act.replace(".", "_", "all")].fileContent);
			generated++;
		}, true);

		// Generate posts
		var posts = PostService.list();
		posts.each((post) => {
			cfhttp(url = "127.0.0.1:" & cgi.SERVER_PORT & "/post/" & post.slug, result = post.slug.replace("-", "_", "all"));
			fileWrite(expandPath(".") & "/dist/post/" & post.slug & ".html", variables[post.slug.replace("-", "_", "all")].fileContent);
			generated++;
		}, true);

		// Generate pages
		var pages = PageService.list();
		pages.each((page) => {
			cfhttp(url = "127.0.0.1:" & cgi.SERVER_PORT & "/page/" & page.slug, result = page.slug.replace("-", "_", "all"));
			fileWrite(expandPath(".") & "/dist/page/" & page.slug & ".html", variables[page.slug.replace("-", "_", "all")].fileContent);
			generated++;
		}, true);

		// Generate Tags
		tags.each((tag) => {
			cfhttp(url = "127.0.0.1:" & cgi.SERVER_PORT & "/tag/" & tag, result = tag.replace("-", "_", "all"));
			fileWrite(expandPath(".") & "/dist/tag/" & tag & ".html", variables[tag.replace("-", "_", "all")].fileContent);
			generated++;
		}, true);

		return "Build complete: " & generated & " documents generated in " & (getTickCount() - start ) & " ms";
	}

}