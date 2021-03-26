<template>
  <div class="container padding-top">
    <div class="columns">
      <div class="column">
        <input class="input is-info" type="text" placeholder="タイトル" v-model="title" />
      </div>
      <div class="column">
        <button class="button is-danger unique-font">Submit</button>
      </div>
    </div>
    <div class="columns padding-top">
      <div class="field column">
        <div class="control">
          <textarea class="textarea form-height" placeholder="本文" v-model="article"></textarea>
        </div>
      </div>
      <div class="field column">
        <div v-html="$md.render(article)"></div>
      </div>
    </div>
  </div>
</template>

<script lang="ts">
import { Provide, Model, Component, Vue } from 'nuxt-property-decorator'
import axios from 'axios'
import '~/node_modules/katex/dist/katex.min.css'

@Component({ name: 'den' })
export default class den extends Vue {
  title: string = ''
  article: string =
    '\n  $f(x) = \\frac{1}{\\sqrt {2\\pi \\sigma^2}} \\exp\\Biggl(-\\frac{(x-\\mu)^2}{2\\sigma^2}\\Biggr) \\qquad (-\\infty<x<\\infty)$'

  async write() {
    let post_json = [
      {
        assumption_id: 1,
        user_id: 0, //TODO
        title: this.title,
        article: this.article,
      },
    ]
    //TODO
    axios.post('/articles', JSON.stringify(post_json))
  }
}
</script>
