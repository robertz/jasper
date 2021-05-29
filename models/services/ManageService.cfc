component output = "false" hint = "Handle Jasper Management Tasks" {

	property name = "PostService" inject;
	property name = "PageService" inject;

	function generateStaticContent (required struct prc) {
		var start = getTickCount();

		var posts = PostService.list();
		var pages = PageService.list();
		var tags = PostService.getTags();
		var generated = 0;

		// ColdBox handlers generate pages and where to write the file
		var contentPages = [
			{ act: "main.index", file: "index.html" },
			{ act: "main.notfound", file: "404.html" }
		];

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

		posts.each((post) => {
			cfhttp(url = "127.0.0.1:" & cgi.SERVER_PORT & "/post/" & post.slug, result = post.slug.replace("-", "_", "all"));
			fileWrite(expandPath(".") & "/dist/post/" & post.slug & ".html", variables[post.slug.replace("-", "_", "all")].fileContent);
			generated++;
		}, true);

		// Generate pages
		pages.each((page) => {
			cfhttp(url = "127.0.0.1:" & cgi.SERVER_PORT & "/page/" & page.slug, result = page.slug.replace("-", "_", "all"));
			fileWrite(expandPath(".") & "/dist/page/" & page.slug & ".html", variables[page.slug.replace("-", "_", "all")].fileContent);
			generated++;
		}, true);

		// Generate Tags
		tags.each((tag) => {
			cfhttp(url = "127.0.0.1:" & cgi.SERVER_PORT & "/tag/" & tag.replace(" ", "-", "all"), result = tag.replace(" ", "_", "all"));
			fileWrite(expandPath(".") & "/dist/tag/" & tag & ".html", variables[tag.replace(" ", "_", "all")].fileContent);
			generated++;
		}, true);

		// Generate RSS feed
		var feed = '';
		feed &= '<?xml version="1.0" encoding="utf-8"?><rss version="2.0" xmlns:atom="http://www.w3.org/2005/Atom"><channel><atom:link href="#prc.meta.url#/feed.xml" rel="self" type="application/rss+xml" /><title>#prc.meta.title#</title><link>#prc.meta.url#</link>';
		feed &= '<description>#prc.meta.description#</description><lastBuildDate>#dateFormat(now(), "ddd, dd mmm yyyy")# #timeFormat(now(), "HH:mm:ss XX")#</lastBuildDate>';
		feed &= '<language>en-us</language><generator>Jasper</generator>';
		posts.each((post) => {
			feed &= '<item><title>#post.title#</title><link>#prc.meta.url#/post/#post.slug#</link><guid isPermalink="true">#prc.meta.url#/post/#post.slug#</guid>';
			feed &= '<pubDate>#dateFormat(post.publishDate, "ddd, dd mmm yyyy")# #timeFormat(post.publishDate, "HH:mm:ss XX")#</pubDate><description><![CDATA[#post.description#]]></description>';
			for(var tag in post.tags) feed &= '<category>#tag#</category>';
			feed &= '</item>';
		});
		feed &= '</channel></rss>';
		fileWrite(expandPath(".") & "/dist/feed.xml", feed);

		return "Build completed in " & (getTickCount() - start) & " ms.";
 	}

}