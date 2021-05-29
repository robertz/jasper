<cfoutput>
<div>
	<div class="shadow rounded p-2 mb-3">
		<p>
			<h6>- Jasper</h6>
			<small>
				This would be a good place to put a few blurbs about yourself.
			</small>
		</p>
	</div>
	<div class="shadow rounded p-2">
		<p>
			<h6>- Tags</h6>
			<cfloop array="#prc.tagCloud#" index="tag">
				<a href="/tag/#tag.replace(" ", "-", "all")#"> <span class="h5"><span class="badge badge-secondary p-2">#tag#</span></span></a>
			</cfloop>
		</p>
	</div>
</div>
</cfoutput>