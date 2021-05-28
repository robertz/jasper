<cfoutput>
	<div class="row lazy">
		<div class="col-lg-2 d-none d-lg-block d-xl-block"></div>
		<div class="col-lg-8 col-md-12">


			<div class="row mt-3">
				<div class="col-lg-8 col-md-12 post">
					<cfloop array="#prc.posts#" item="post">
						<div class="card w-100 mb-3">
							<a href="/post/#post.slug#" alt="#post.title#">
								<img src="#post.image#" class="card-img-top feed-item" alt="">
							</a>
							<div class="card-body">
								<p class="card-text">
									<div>
										<cfloop array="#post.tags#" item="tag">
											<span class="badge badge-secondary">#tag#</span>
										</cfloop>
									</div>
									<p><a class="h4 post-link" href="/post/#post.slug#">#post.title#</a></p>
									<div class="mb-2">
										<strong>#post.author#</strong><br />
										<span class="text-muted small">#dateFormat(post.publishDate, "mmm dd, yyyy")#</span>
									</div>
									<p class="small">#post.description#</p>
								</p>
							</div>
						</div>

					</cfloop>
				</div>

				<div class="col-lg-4 d-none d-lg-block d-xl-block">
					#renderView("partials/sidebar")#
				</div>

			</div>


		</div>
		<div class="col-lg-2 hidden-md"></div>
	</div>
</cfoutput>