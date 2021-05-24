<cfoutput>
	<div class="row lazy">
		<div class="col-md-2 hidden-sm"></div>
		<div class="col-md-8 col-sm-12 post">
			<cfif prc.page.status eq "ok">
				<div class="mb-3">
					<p class="h2">#prc.page.title#</p>
				</div>
				#prc.html#
			<cfelse>
				<div class="text-center mt-5">
					<img src="https://static.kisdigital.com/images/notfound.jpeg" alt="" class="h-50 w-50">
				</div>
			</cfif>
		</div>
		<div class="col-md-2 hidden-sm"></div>
	</div>
</cfoutput>