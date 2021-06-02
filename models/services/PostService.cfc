component {

	property name="YamlService" inject="Parser@cbyaml";

	// get metadata for the post
	function getFrontMatter(required string slug) {
		var data = {
			'slug': slug,
			'tags': [],
			'status': "error"
		};

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
		}

		return data;
	}

	// get list of articles, try pulling from cache first
	function list() {
		var files = directoryList(path = expandPath(".") & "/posts/", listInfo = "query");
		var posts = [];
		files.each((file) => {
			// get details for each post
			var post = getFrontMatter(slug = replace(listLast(file.name, "/"), ".md", ""));
			if(post.keyExists("published") && post.published) posts.append(post);
		});
		posts.sort((e1, e2) => {
			return dateCompare(e2.publishDate, e1.publishDate); // desc
		});
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