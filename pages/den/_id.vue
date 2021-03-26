<template>
  <div class="container padding-top">
    <div class="columns">
      <div class="column">
        <input
          class="input is-info"
          type="text"
          placeholder="タイトル"
          v-model="title"
        />
      </div>
      <div class="column">
        <button class="button is-danger unique-font" @click="submit">
          Submit
        </button>
      </div>
    </div>
    <div class="columns padding-top">
      <div class="field column">
        <div class="control">
          <textarea
            class="textarea form-height"
            placeholder="本文"
            v-model="article"
          ></textarea>
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
import '~/node_modules/katex/dist/katex.min.css'
import 'vue-router'
import axios from 'axios'

axios.defaults.baseURL = 'http://127.0.0.1:8000'
axios.defaults.headers.post['Content-Type'] = 'application/json;charset=utf-8'
axios.defaults.headers.post['Access-Control-Allow-Origin'] = '*'

@Component({ name: 'den' })
export default class den extends Vue {
  title: string = ''
  assumption_id: string = this.$route.params.id
  article: string =
    '\n  $f(x) = \\frac{1}{\\sqrt {2\\pi \\sigma^2}} \\exp\\Biggl(-\\frac{(x-\\mu)^2}{2\\sigma^2}\\Biggr) \\qquad (-\\infty<x<\\infty)$'
  async write() {
    let post_json = {
      assumption_id: this.assumption_id,
      user_id: 0,
      title: this.title,
      article: this.article,
    }

    const response = await axios
      .post('http://127.0.0.1:8000/articles', post_json)
      .catch((err) => {
        return err.response
      })

    if (response.status != 200) {
      console.log('error!')
    } else {
      console.log('Success!,you submit article!')
    }
  }

  submit() {
    if (this.title != '' && this.article != '') {
      this.write()
    }
  }
}
</script>
