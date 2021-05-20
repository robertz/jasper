# Blog
A lightweight blog implementation

Blog allows you to create a blog with markdown files, similar to a static site generator. Creating a post is as easy as generating a new markdown file with the proper front matter and markdown

``` md
---
title: New post title goes here
author: Robert Zehnder
description: This would be a pretty good spot to summarize what you are writing about 
tags: 
- awesome
image: https://static.kisdigital.com/images/marvel/00_anthology.jpg
published: false
publishedDate: 2021-05-16
---

### Awesome

Type it out
```

No database is required so everything is cached for performance. Currently this is the default ColdBox object cache. Might need to be moved later. The caching is pretty agressive, you can pass the `rb` url parameter to force a cache rebuild on any url.
## Quick Installation

Each application templates contains a `box.json` so it can leverage [CommandBox](http://www.ortussolutions.com/products/commandbox) for its dependencies.  
Just go into each template directory and type:

```bash
box install
```

This will setup all the needed dependencies for each application template.  You can then type:

```bash
box server start
```

And run the application.
