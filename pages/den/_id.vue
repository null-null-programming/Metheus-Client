<template>
<amplify-authenticator class="amplify-css">
  <div class="container padding-top">
    <div>
    <button class="button is-danger unique-font">
      <NuxtLink class="title is-2 has-text-white" :to="{ path :'/category'}">
      Back
      </NuxtLink>
    </button>
    </div>
    <div class="columns padding-top">
      <div class="column">
        <input
          class="input is-info"
          type="text"
          placeholder="タイトル"
          v-model="title"
        />
      </div>
      <div class="column is-4">
        <button class="button is-danger unique-font">
          <span class="submit">Submit</span>
          <span class="loading"><i class="fa fa-refresh"></i></span>
          <span class="check"><i class="fa fa-check"></i></span>
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
  </amplify-authenticator>
</template>

<script lang="ts">
import { Provide, Model, Component, Vue } from 'nuxt-property-decorator'
import '~/node_modules/katex/dist/katex.min.css'
import 'vue-router'
import axios from 'axios'
import { Auth } from 'aws-amplify'

axios.defaults.baseURL ='http://127.0.0.1:8000'
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
      title: this.title,
      article: this.article,
    }

    let idToken = null
     await Auth.currentSession()
      .then(data => {
        idToken = data.getIdToken().getJwtToken()
      })
    
    console.log(idToken)
    
    await axios.post('http://0.0.0.0:8000/articles',post_json,{
        headers: {
          "Authorization": idToken
        }
      })
  }

  submit() {
    if (this.title != '' && this.article != '') {
      this.write()
    }
  }
}
</script>