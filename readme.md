## Jasper

Jasper is a blog written in ColdFusion aiming to make blogging as simple as possible. Adding a new post is as easy as creating a new markdown file in the `/posts` directory.

Jasper also allows you to create `pages` which allow you to use markdown outside of blog posts.

No database is required in an attempt to keep things as simple as possible, details for each post are read from the front matter of the blog posts.

``` md
---
title: New post title goes here
author: `jasper`
description: This would be a pretty good spot to summarize what you are writing about 
tags: 
- awesome
image: https://static.kisdigital.com/images/marvel/00_anthology.jpg
published: false
publishDate: 2021-05-16
---

### Awesome

My awsome blog post starts here
```
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
