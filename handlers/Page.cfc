component {

	property name = "PageService" inject;
	property name = "MarkdownService" inject = "Processor@cbmarkdown";

	function get (event, rc, prc){
		prc['page'] = PageService.getFrontMatter(slug = rc.slug);
		prc['html'] = MarkdownService.toHTML(PageService.getMarkdown(slug = rc.slug).markdown);

		event.setView( prc.page.status == "ok" ? "page/view" : "main/404" );
	}

}