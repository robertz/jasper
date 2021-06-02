---
title: Getting Started
author: Jasper
description: It is pretty easy to get started with Jasper, here are some steps to help you move forward
tags: 
- Jasper
- Getting Started
image: https://static.kisdigital.com/images/jasper/getting-started-00-cover.jpeg
published: true
publishDate: 2020-05-30
---

![Cover](https://static.kisdigital.com/images/jasper/getting-started-00-cover.jpeg)

Jasper does not require any backend to operate so it is very easy to get up and running. If you are famiilar with ColdBox, even more so.

There are a few important directories for Jasper:

* **/posts** - This folder is where the markdown is stored for blog posts
* **/pages** - This folder has markdown pages that will be rendered, such as the readme file above
* **/assets** - This folder should contain all the assets you will need in production. This directory will be copied to the `/dist` folder as part of the build process
* **/dist** - This foler contains the HTML when it is generated

Creating a post with Jasper is easy as creating a new markdown file with the proper front matter. Start the development server with `box server start` and you can see how the blog will look in production. There is no "live reload" that you might expect with webpack or other HTML build systems, but you can manually reload the page to see your changes.

Jasper uses ColdBox to render all HTML. Here are a few important files to be aware of.

* **/handlers/Main** - The main ColdBox handler for the home page. This handler is also used for generating other pages on the blog like the 404 page, etc.
* **/handlers/Page** - This handler renders markdown content that is not a post
* **/handlers/Post** - This handler renders blog posts as well as filtering by tag
* **/handlers/Manage** - This hanlder controls building blog content
* **/layouts/Main.cfm** - This is the main layout file for the blog. ColdBox supports multiple layouts, add as many layouts as you want.
* **/models/JasperConfig** - Customize your Jasper Configuration
* **/models/PageService** - This component contains is responsible for reading front matter and markdown for pages
* **/models/PostService** - This component contains the methods responsible for reading front matter, markdown, and listing posts. Post service also handles writing oout opengraph and twitter metadata to ensure your post is properly attributed when shared
* **/models/ManageService** - This component contains the methods responsible for writing the HTML out to the `/dist` folder

### Configuring Settings (JasperConfig)

``` javascript
component output = "false" {
	// return the config
	function getConfig() {
		return {
			'meta': { // Jasper metadata used in site layout
				'title': "Jasper", // title bar
				'description': "A description of your blog", // meta description
				'author': "Jasper",
				'url': "https://example.com"
			},
			'contentPages': [ // Coldbox pages to generate and where to write it to
				{ action: "main.index", file: "index.html" },
				{ action: "main.notfound", file: "404.html" }
			]
		}
	}
}
```

Currently there are only minimal settings available.

### Generating Static Content

Once the content has been created it is time to generate the static site. Currently the Manage handler has to main actions:

* build - Attempts to build the site content, copies the dist folder to a production repo
* deploy - Builds the content, copies `dist/` folder to the production repo, calls a bash script to commit the changes and push it to GitHub.

The build is triggered by hitting the build URL, http://127.0.0.1:60783/manage/build for example. If successful you should see a message like `10 document(s) generated in 112 ms.`The build process builds a list of all pages, posts, and tags and calls each one using `cfhttp`; the resulting HTML is then written to disk. This process also generates an RSS 2.0 XML feed for your posts.

This is process is handled in `ManageService.generateStaticContent()` and `ManageService.generateFeedXml`.
