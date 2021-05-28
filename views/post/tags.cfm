<cfoutput>
	<div class="row lazy">
		<div class="col-lg-2 hidden-md"></div>
		<div class="col-lg-8 col-md-12 post">
			<p class="h2">#rc.tag#</p>
			<p class="h6">#prc.posts.len()# total post(s)</p>
			<cfloop array="#prc.posts#" item="post">
				<a href="/post/#post.slug#">#post.title#</a> - <small class="text-muted">#dateFormat(post.publishDate, "mmmm dd, yyyy")#</small><br />
			</cfloop>
		</div>
		<div class="col-lg-2 hidden-md"></div>
	</div>
</cfoutput>