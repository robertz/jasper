component extends="coldbox.system.web.context.RequestContextDecorator" {

	property name="Controller" inject="coldbox";

	function configure(){
		var rc = getRequestContext().getCollection();
		var prc = getRequestContext().getCollection(private = true);

		prc['meta']['title'] = "Blog";
		prc['meta']['description'] = "Blog Description";
		prc['meta']['author'] = "John Smith";

		prc['headers'] = [];

		if(rc.keyExists("rb")) cacheClear();

		return this;
	}

}