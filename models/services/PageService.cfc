component {

	property name="YamlService" inject="Parser@cbyaml";

	// get metadata for the post
	function getFrontMatter(required string slug) {
		var data = {
			'slug': slug,
			'tags': [],
			'status': "error"
		};
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
		}
		return data;
	}

	// get list of pages
	function list() {
		var pages = [];
		var files = directoryList(path = expandPath(".") & "/pages/", listInfo = "query", sort = "dateLastModified DESC");
		files.each((file) => {
			pages.append( getFrontMatter(slug = replace(listLast(file.name, "/"), ".md", "")) );
		});
		return pages;
	}

}