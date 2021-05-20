<cfoutput>
	<div class="row lazy">
		<div class="col-md-2 hidden-sm"></div>
		<div class="col-md-8 col-sm-12 post">
			<cfloop array="#prc.posts#" item="post">
				<div class="card mb-3">
					<img src="#post.image#" class="card-img-top feed-item" alt="">
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
		<div class="col-md-2 hidden-sm"></div>
	</div>
</cfoutput>