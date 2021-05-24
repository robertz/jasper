<cfoutput>
	<div class="row lazy">
		<div class="col-lg-2 hidden-md"></div>
		<div class="col-lg-8 col-md-12 post">
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
				<div class="mb-5">
					#prc.html#
				</div>
				#renderView("partials/author")#
				#renderView("partials/disqus")#
			<cfelse>
				<div class="text-center mt-5">
					<img src="https://static.kisdigital.com/images/notfound.jpeg" alt="" class="h-50 w-50">
				</div>
			</cfif>
		</div>
		<div class="col-lg-2 hidden-md"></div>
	</div>
</cfoutput>