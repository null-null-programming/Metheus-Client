<template>
    <div class="container padding-top">
      <div class="columns">
        <div class="colum">
          <h1 class="title is-1 unique-font">Article</h1>
        </div>
        <div class="colum">
        <button class="button is-danger is-10 unique-font">
          <NuxtLink class="title has-text-white" :to="{ path :'/category'}">
            Back
          </NuxtLink>
        </button>
        </div>
        <div class="colum">
          <button class="button is-primary unique-font">
            <NuxtLink class="title has-text-white" :to="{ path: '/den/'+id }"
              >write</NuxtLink
            >
          </button>
          </div>
        </div>
    <div class="container">
      <ul id="articles_title">
        <li v-for="(article,index) in articles" v-bind:key="article.id">
          <div class="columns padding-top">
          <div class="colum tile is-ancestor is-primary padding-top pcs-width">
            <article class="tile is-child notification is-white">
              <NuxtLink
                class="title is-10 unique-font padding-top"
                key="title"
                :to="{ path: '/articles/' + article.id }"
                >{{ article.title }}</NuxtLink
              >
            </article>
            </div>
          <div class="colum" style="padding-left:30px;">
            <div class="Likes" v-if="articles.length>1">
                <div class="LikesIcon" v-bind:class="animation[index]" @click="fav(index)"></div>
              </div>
          </div>
          </div>
        </li>
      </ul>
    </div>
  </div>
</template>

<script lang="ts">
import { Component, Vue } from 'nuxt-property-decorator'
import axios from 'axios'
import { Auth } from 'aws-amplify'

@Component({ name: 'Assumptions' })
export default class Assumptions extends Vue {
  articles: any = null
  id: string=this.$route.params.id.toString()
  animation: Array<string> = []
  flag: Array<boolean> = []

  async AssumptionsFetch() {
    const response = await fetch(
      ' http://0.0.0.0:8000/assumptions/' + this.id
    )
    if (!response.ok) {
      const err = await response.json()
      throw new Error(err)
    }
    this.articles = await response.json()

    console.log('success!,get Articles!')
  }

  
async getFavData() {
    let idToken = null
    console.log('getFavData()')

     try{
     await Auth.currentSession()
      .then(data => {
        idToken = data.getIdToken().getJwtToken()
      })}catch(error){
        console.log(error)
        return
      } 

    await axios.get('http://0.0.0.0:8000/like',{
        headers: {
          "Authorization": idToken
        }
      }).then(response => {
         this.flag=response.data
      }).catch(error=>{
        console.log(error)
        return
      })
    
    for(let index in this.flag){
      if(this.flag[index]===true){
        this.$set(this.animation,index,"HeartAnimation")
      }else{
        this.$set(this.animation,index,"")
      }
    }
 }

  //TODO　APIと通信してDBの情報を更新する。
  fav(index:number){
    if (this.flag[index]) {
      this.$set(this.flag,index,false)
      this.$set(this.animation,index,"")
      this.$set(this.animation,index,"background-position:left")
    } else {
      this.$set(this.flag,index,true)
      this.$set(this.animation,index,"HeartAnimation")
    }
  }

  created() {
    this.AssumptionsFetch()
    this.getFavData()
  }

}
</script>

<style lang="scss" href="../../assets/css/style.scss"></style>
