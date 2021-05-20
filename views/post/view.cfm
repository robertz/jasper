<cfoutput>
	<div class="row lazy">
		<div class="col-md-2 hidden-sm"></div>
		<div class="col-md-8 col-sm-12 post">
			<cfif prc.post.status eq "ok">
				<div class="mb-3">
					<div>
						<cfloop array="#prc.post.tags#" item="tag">
							<span class="badge badge-secondary">#tag#</span>
						</cfloop>
					</div>
					<p class="h2">#prc.post.title#</p>
					<div class="mb-2">
						<strong>#prc.post.author#</strong><br />
						<span class="text-muted small">#dateFormat(prc.post.publishDate, "mmm dd, yyyy")#</span>
					</div>
					<p class="small">#prc.post.description#</p>
				</div>
				#prc.html#
			<cfelse>
				<div class="alert alert-danger">
					<strong>Uh Oh!</strong> There was an error with your request.
				</div>
			</cfif>
		</div>
		<div class="col-md-2 hidden-sm"></div>
	</div>
</cfoutput>