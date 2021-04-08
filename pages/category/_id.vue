<template>
  <div class="container padding-top">
    <div>
    <button class="button is-danger unique-font">
      <NuxtLink class="title is-2 has-text-white" :to="{ path :'/category'}">
      Back
      </NuxtLink>
    </button>
    </div>
    <div>
      <ul id="assumptions_title">
        <li v-for="(assumption,index) in assumptions" v-bind:key="assumption.id">
          <div class="columns">
          <div class="tile is-ancestor is-primary padding-top pc-width">
            <article class="tile is-child notification is-white">
              <NuxtLink
                class="title is-2 unique-font padding-top"
                key="title"
                :to="{ path: '/assumptions/' + assumption.id }"
                >{{ assumption.title }}</NuxtLink
              >
            </article>
          </div>
          <div class="colum" style="padding-left:30px;">
            <div class="Likes">
                <div class="LikesIcon" v-bind:class="{'HeartAnimation':flag[index]}" @click="fav(index)"></div>
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
import 'vue-router'
import $ from 'jquery';
import axios from 'axios'
import { Auth } from 'aws-amplify'


@Component({ name: 'Assumptions' })
export default class Assumptions extends Vue {
  assumptions: any = null
  id: string = this.$route.params.id
  //TODO MariaDB
  flag: Array<boolean> =[false,false,false,false,false,false,false,false,false,false]

  async AssumptionsFetch() {
    const response = await fetch('http://0.0.0.0:8000/category/' + this.id)
    if (!response.ok) {
      const err = await response.json()
      throw new Error(err)
    }
    this.assumptions = await response.json()
  }


toBoolean(booleanStr: string): boolean {
    return booleanStr.toLowerCase() === "true";
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

      console.log(idToken)
    let favDict
    await axios.get('http://0.0.0.0:8000/like',{
        headers: {
          "Authorization": idToken
        }
      }).then(response => {
        //@ts-ignore
         favDict=response.data
      }).catch(error=>{
        console.log(error)
        return
      })

    console.log(favDict)

    for(let index in favDict){
      if(this.toBoolean(favDict[index])==true){
        this.$set(this.flag,index,true)
      }else{
        this.$set(this.flag,index,false)
      }
    }

    console.log(this.flag)
    console.log('hye')
 }

  fav(index:number){
    let $btn = $("LikesIcon")
    if (this.flag[index]) {
      this.$set(this.flag,index,false)
      $btn.css("background-position","left");
    } else {
      this.$set(this.flag,index,true)
    }
  }

  setFavFunc(index:number){
    let $btn = $("LikesIcon")
    this.$set(this.flag,index,true)
  }

  setFav(){
    for(let index in this.flag){
      if(this.flag[index]==true){
        this.$set(this.flag,index,true)
      }
    }
  }

  created() {
    this.AssumptionsFetch()
    this.getFavData()
  }

  mounted(){
    this.setFav()
  }
}
</script>

<style lang="scss" href="../../assets/css/style.scss"></style>
