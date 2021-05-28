component {

	property name="YamlService" inject="Parser@cbyaml";
	property name="env" inject="coldbox:setting:environment";

	// get metadata for the post
	function getFrontMatter(required string slug) {
		var data = {
			'slug': slug,
			'tags': [],
			'status': "error"
		};
		var post = cacheGet(id = "fm_" & data.slug);
		if(!isDefined("post") || variables.env == "development"){
			// file operation
			if(fileExists(expandPath(".") & "/posts/" & slug & ".md")){
				var openFile = fileopen( expandPath(".") & "/posts/" & slug & ".md", "read" );
				var lines = [];
				try {
					while( !fileIsEoF( openFile ) ) {
						arrayAppend( lines, fileReadLine( openFile ) );
					}
				} catch( any e ) {
					rethrow;
				} finally {
					fileClose( openFile );
				}
				var fme = lines.findAll("---")[2]; // front matter end
				var yaml = "";
				for(var i = 2; i < fme; i++){
					yaml &= lines[i] & chr(10);
				}
				data.append(YamlService.deserialize(yaml));
				data.status = lines.len() ? "ok" : "error";
				// cache the object if it was successful
				if(data.status == "ok") cachePut(id = "fm_" & data.slug, value = data);
			}
		}
		else {
			data.append(post);
		}
		return data;
	}

	// get the md data for the post
	function getMarkdown(required string slug) {
		var data = {
			'slug': slug,
			'markdown': "",
			'status': "error"
		};
		var post = cacheGet(id = "md_" & data.slug);
		if(!isDefined("post") || variables.env == "development"){
			// file operation
			if(fileExists(expandPath(".") & "/posts/" & slug & ".md")){
				var openFile = fileopen( expandPath(".") & "/posts/" & slug & ".md", "read" );
				var lines = [];
				try {
					while( !fileIsEoF( openFile ) ) {
						arrayAppend( lines, fileReadLine( openFile ) );
					}
				} catch( any e ) {
					rethrow;
				} finally {
					fileClose( openFile );
				}
				var fme = lines.findAll("---")[2]; // front matter end
				lines.each((line, row) => {
					if(row > fme) data['markdown'] &= line.len() ? (line & chr(10)) : (" " & chr(10));
				});
				data.status = lines.len() ? "ok" : "error";
				// cache the object if it was successful
				if(data.status == "ok") cachePut(id = "md_" & data.slug, value = data);
			}
		}
		else {
			data.append(post);
		}
		return data;
	}

	// get list of articles, try pulling from cache first
	function list() {
		var posts = cacheGet(id = "posts");
		if(!isDefined("posts") || env == "development"){
			var files = directoryList(path = expandPath(".") & "/posts/", listInfo = "query", sort = "dateLastModified DESC");
			var posts = [];
			files.each((file) => {
				// get details for each post
				var post = getFrontMatter(slug = replace(listLast(file.name, "/"), ".md", ""));
				if(post.keyExists("published") && post.published) posts.append(post);
			});
			posts.sort((e1, e2) => {
				return compare(e2.publishDate, e1.publishDate); // desc
			});
			cachePut(id = "posts", value = posts);
		}
		return posts;
	}

	function getTags() {
		var tags = [];
		var posts = list();

		// Calculate tags
		posts.each(function(post){
			for(var tag in post.tags) if(!tags.find(tag)) tags.append(tag);
		});
		return tags;
	}
}