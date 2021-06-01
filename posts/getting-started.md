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

### Getting Started

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
* **/models/RequestContextDecorator** - The request context decorator contains all the variables/meta data required to render the page. Blog specific header data is set in the request context decorator as well.
* **/models/PageService** - This component contains is responsible for reading front matter and markdown for pages
* **/models/PostService** - This component contains the methods responsible for reading front matter, markdown, and listing posts. Post service also handles writing oout opengraph and twitter metadata to ensure your post is properly attributed when shared
* **/models/ManageService** - This component contains the methods responsible for writing the HTML out to the `/dist` folder

### Configuring Settings

``` javascript
component extends="coldbox.system.web.context.RequestContextDecorator" {

	property name="Controller" inject="coldbox";

	function configure(){
		var rc = getRequestContext().getCollection();
		var prc = getRequestContext().getCollection(private = true);

		prc['meta']['title'] = "Jasper";
		prc['meta']['description'] = "Blog Description";
		prc['meta']['url'] = "https://example.com"
		prc['meta']['author'] = "Jasper";

		prc['headers'] = [];

		return this;
	}

}
```

Currently there are only minimal settings in `models.RequestContextDecorator`, namely the meta data required to set social sharing options and the `prc['headers']` array used in the layout.

### Generating Static Content

Once the content has been created it is time to generate the static site. Currently the Manage handler has to main actions:

* build - Attempts to build the site content, copies the dist folder to a production repo
* deploy - Builds the content, copies `dist/` folder to the production repo, calls a bash script to commit the changes and push it to GitHub.

The build is triggered by hitting the build URL, http://127.0.0.1:60783/manage/build for example. If successful you should see a message like `Build completed in 534 ms.`The build process builds a list of all pages, posts, and tags and calls each one using `cfhttp`; the resulting HTML is then written to disk. This process also generates an RSS 2.0 XML feed for your posts.

This is process is handled in `ManageService.generateStaticContent()`

**Content Pages**

Content pages are the pages that are manually triggered to be generated and consist of the ColdBox URL to generate the HTML and the file to write the contents out for. This is used to generate the home page as well as a custom 404 page.

``` javascript
		// ColdBox handlers generate pages and where to write the file
		var contentPages = [
			{ act: "main.index", file: "index.html" },
			{ act: "main.notfound", file: "404.html" }
		];

```

The deploy action is specific to my configuration with Netlify. Netlify can watcha repo for commits, and the `deploy` action generates the static files in the `/dist` directory and then copies them to the blog's ssg repo. A bash script is then executed that creates a new commit and pushes it to GitHub.

**blog/commit.sh**

``` bash
#!/bin/bash
cd ~/static
git add --all
git commit -m "Build triggered"
git push
```

Netlify will see the commit and start a new build.