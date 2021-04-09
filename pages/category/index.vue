<template>
  <div>
    <div class="container">
      <h1 class="title is-1 unique-font padding-top">Category</h1>
    </div>
    <div class="container">
      <ul id="categoryTitle">
        <li v-for="(category,index) in categories" v-bind:key="category.id">
          <div class="columns padding-top">
            <div class="colum">
          <div class="tile is-ancestor is-primary padding-top pc-width">
            <article class="tile is-child notification is-white">
              <NuxtLink
                class="tile title unique-font"
                :to="{path : '/category/'+category.id}"
              >{{ category.name }}</NuxtLink>
            </article>
            </div>
            </div>
            <div v-if="signed_in">
          <div class="colum" style="padding-left:30px;" v-if="categories&&categories.length>1">
            <div class="Likes">
                <div class="LikesIcon" v-bind:class=animation[index] @click="fav(index)"></div>
              </div>
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

@Component({ name: 'CategoryList' })
export default class CategoryList extends Vue {
  categories: any = null
  animation: Array<string> =[]
  flag: Array<boolean> = []
  signed_in: boolean = false

  async Fetch() {
    const response = await fetch('http://0.0.0.0:8000/category')
    if (!response.ok) {
      const err = await response.json()
      throw new Error(err)
    }
    this.categories = await response.json()
    console.log('success!')
  }

  async getFavData() {
    let idToken = null

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

 async setFav(index: number,nextFlag: boolean){
    let idToken = null
    
     try{
     await Auth.currentSession()
      .then(data => {
        idToken = data.getIdToken().getJwtToken()
      })}catch(error){
        console.log(error)
        return
      } 

    await axios.put('http://0.0.0.0:8000/like',{
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

  async loginFlag(){
     this.signed_in=true
     await Auth.currentUserInfo()
    .then(data => this.signed_in = Boolean(data))
    .catch(err => console.log(err))
    console.log(this.signed_in)
    return this.signed_in
  }


  created() {
    this.Fetch()
    this.loginFlag()
    this.getFavData()
  }
}
</script>

<style lang="scss" href="../../assets/css/style.scss"></style>
