component extends="coldbox.system.web.context.RequestContextDecorator" {

	property name="Controller" inject="coldbox";

	function configure(){
		var rc = getRequestContext().getCollection();
		var prc = getRequestContext().getCollection(private = true);
		var config = new models.JasperConfig().getConfig();
		prc['headers'] = [];
		prc.append(config);

		return this;
	}

}