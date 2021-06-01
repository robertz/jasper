component {

	property name = "PostService" inject;
	property name = "MarkdownService" inject = "Processor@cbmarkdown";

	function get (event, rc, prc){
		prc['post'] = PostService.getFrontMatter(slug = rc.slug);
		prc['tagCloud'] = PostService.getTags();
		prc['html'] = MarkdownService.toHTML(PostService.getMarkdown(slug = rc.slug).markdown);

		if(prc.post.status == "ok"){
			prc.meta.title &= " - " & prc.post.title;
			prc['headers'] = [];
			prc.headers.append({'property': "og:title", 'content': "#prc.post.title#"});
			prc.headers.append({'property': "og:description", 'content': "#prc.post.description#"});
			prc.headers.append({'property': "og:image", 'content': "#prc.post.image#"});
			prc.headers.append({'name': "twitter:card", 'content': "summary_large_image"});
			prc.headers.append({'name': "twitter:title", 'content': "#prc.post.title#"});
			prc.headers.append({'name': "twitter:description", 'content': "#prc.post.description#"});
			prc.headers.append({'name': "twitter:image", 'content': "#prc.post.image#"});
		}

		event.setView("post/view");
	}

	function filterByTag (event, rc, prc) {
		var posts = PostService.list();
		prc['tag']= rc.tag.replace("-", " ", "all")
		prc['posts'] = posts.filter((post) => {
			return post.tags.find(prc.tag);
		});

		event.setView("post/tags");
	}

}