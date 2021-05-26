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
			if(fileExists( expandPath(".") & "/pages/" & slug & ".md")){
				var openFile = fileopen( expandPath(".") & "/pages/" & slug & ".md", "read" );
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
		var post = cacheGet(id = "md_page_" & data.slug);
		if(!isDefined("post") || variables.env == "development"){
			// file operation
			if(fileExists(expandPath(".") & "/pages/" & slug & ".md")){
				var openFile = fileopen( expandPath(".") & "/pages/" & slug & ".md", "read" );
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
				if(data.status == "ok") cachePut(id = "md_page_" & data.slug, value = data);
			}
		}
		else {
			data.append(post);
		}
		return data;
	}

	// get list of pages, try pulling from cache first
	function list() {
		var pages = cacheGet(id = "pages");
		if(!isDefined("pages") || env == "development"){
			var files = directoryList(path = expandPath(".") & "/pages/", listInfo = "query", sort = "dateLastModified DESC");
			var pages = [];
			files.each((file) => {
				// get details for each post
				var page = getFrontMatter(slug = replace(listLast(file.name, "/"), ".md", ""));
				pages.append(page);
			});
			cachePut(id = "pages", value = pages);
		}
		return pages;
	}

}