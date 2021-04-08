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
          <div class="colum" style="padding-left:30px;" >
              <div class="Likes" v-if="categories.length>1">
                <div class="LikesIcon" v-bind:class=animation[index]  @click="fav(index)"></div>
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

  fav(index:number){
    if (this.flag[index]) {
      this.$set(this.flag,index,false)
      this.animation[index]="background-position:left"
    } else {
      this.$set(this.flag,index,true)
    }
  }


  created() {
    this.Fetch()
    this.getFavData()
  }
}
</script>

<style lang="scss" href="../../assets/css/style.scss"></style>
