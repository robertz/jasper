component output = "false" {
	// return the config
	function getConfig() {
		return {
			'meta': {
				'title': "Jasper",
				'description': "A description of your blog",
				'author': "Jasper",
				'url': "https://example.com"
			},
			'contentPages': [
				{ action: "main.index", file: "index.html" },
				{ action: "main.notfound", file: "404.html" },
				{ action: "main.search", file: "search.html" }
			]
		}
	}
}