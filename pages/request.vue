<template>
<amplify-authenticator>
  <div class="container padding-top">
      <nuxt/>
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
</amplify-authenticator>
</template>

<script lang="ts">
import { Provide, Model, Component, Vue } from 'nuxt-property-decorator'
import '~/node_modules/katex/dist/katex.min.css'
import 'vue-router'
import { Auth } from 'aws-amplify'
import axios from 'axios'

axios.defaults.baseURL = 'http://0.0.0.0:8000'
axios.defaults.headers.post['Content-Type'] = 'application/json;charset=utf-8'
axios.defaults.headers.post['Access-Control-Allow-Origin'] = '*'

@Component({ name: 'den' })
export default class den extends Vue {
  title: string = ''
  assumption_id: string = this.$route.params.id
  article: string =""  
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

  async edit() {
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
    
    await axios.put('http://0.0.0.0:8000/articles',post_json,{
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

  middleware: 'auth'
}
</script>