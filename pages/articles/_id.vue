<template>
  <div class="container padding-top">
    <div>
      <div class="column">
          <h1 class="title is-1 unique-font padding-top" v-html="title"></h1>
      </div>
      <div>
        <div v-html="$md.render(comment)"></div>
      </div>
    </div>
  </div>
</template>

<script lang="ts">
import { Provide, Model, Component, Vue } from 'nuxt-property-decorator'
import '~/node_modules/katex/dist/katex.min.css'
import 'vue-router'

@Component({ name: 'article' })
export default class den extends Vue {
  title: string = ""
  comment: string=  ""
  id: string=this.$route.params.id.toString()

  async ArticleFetch() {
    const response = await fetch('http://0.0.0.0:8000/articles/' + this.id)
    if (!response.ok) {
      const err = await response.json()
      
    }
    let json = await response.json()
     this.title=json[0].title
     this.comment=json[0].article

    console.log('success!,get Assumptions!')
  }

  created(){
      this.ArticleFetch()
  }
  
}

</script>