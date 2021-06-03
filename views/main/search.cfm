<cfoutput>
<script src="//unpkg.com/lunr@2.1.3/lunr.js"></script>
<script src="//unpkg.com/vue@2.6.13/dist/vue.min.js"></script>

<script>
	window.doc = JSON.parse(JSON.stringify(#prc.docs#))
</script>
</cfoutput>

<div id="search">
	<div class="row lazy">
		<div class="col-lg-2 hidden-md"></div>
		<div class="col-lg-8 col-md-12 post">
			<div class="form-inline">
				<input type="text" class="form-control w-75 m-1" v-model="searchText" placeholder="Enter your search criteria">
				<input type="button" value="Search" class="btn btn-primary m-1" @click="search">
			</div>
			<div v-if="filtered.length">
				<h4>Search Results</h4>
				<p v-for="post in filtered">
					<a :href="'/post/' + docs[post.ref].slug">{{ docs[post.ref].title }}</a> - <small>{{ docs[post.ref].description }}</small>
				</p>
			</div>
		</div>
		<div class="col-lg-2 hidden-md"></div>
	</div>
</div>

<script>
new Vue({
	el: '#search',
	data() {
		return {
			docs: window.doc,
			searchText: "",
			ndx: null,
			filtered: []
		}
	},
	methods: {
		search: function() {
			this.filtered = this.ndx.search(this.searchText)
		}
	},
	created() {
		this.ndx = lunr(function() {
			this.ref('id')
			this.field('slug')
			this.field('title')
			this.field('description')
			this.field('body')
			this.field('author')

			window.doc.forEach(function(doc){
				this.add(doc)
			}, this)
		})
	}
})
</script>