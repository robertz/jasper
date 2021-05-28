<cfoutput>
	<div class="row lazy">
		<div class="col-md-2 hidden-sm"></div>
		<div class="col-md-8 col-sm-12 post">
			<cfif prc.page.status eq "ok">
				<div class="mb-3">
					<p class="h2">#prc.page.title#</p>
				</div>
				#prc.html#
			</cfif>
		</div>
		<div class="col-md-2 hidden-sm"></div>
	</div>
</cfoutput>