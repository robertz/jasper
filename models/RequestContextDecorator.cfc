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