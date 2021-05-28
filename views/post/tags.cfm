<cfoutput>
	<div class="row lazy">
		<div class="col-lg-2 hidden-md"></div>
		<div class="col-lg-8 col-md-12 post">
			<cfloop array="#prc.posts#" item="post">
				<div class="card mb-3">
					<a href="/post/#post.slug#" alt="#post.title#"><img src="#post.image#" class="card-img-top feed-item" alt=""></a>
					<div class="card-body">
						<p class="card-text">
							<div>
								<cfloop array="#post.tags#" item="tag">
									<span class="badge badge-secondary">#tag#</span>
								</cfloop>
							</div>
							<p class="h4">#post.title#</p>
							<div class="mb-2">
								<strong>#post.author#</strong><br />
								<span class="text-muted small">#dateFormat(post.publishDate, "mmm dd, yyyy")#</span>
							</div>
							<p class="small">#post.description#</p>
							<a href="/post/#post.slug#" class="btn btn-primary">Read More</a>
						</p>
					</div>
				</div>
			</cfloop>
		</div>
		<div class="col-lg-2 hidden-md"></div>
	</div>
</cfoutput>