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
          <div v-if="signed_in">
          <div class="colum" style="padding-left:30px;" v-if="assumptions&&assumptions.length>1">
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
import 'vue-router'
import axios from 'axios'
import { Auth } from 'aws-amplify'


@Component({ name: 'Assumptions' })
export default class Assumptions extends Vue {
  assumptions: any = null
  id: string = this.$route.params.id
  flag: Array<boolean>
  animation: Array<string> =[]
  signed_in: boolean = false

  async AssumptionsFetch() {
    const response = await fetch('http://0.0.0.0:8000/category/' + this.id)
    if (!response.ok) {
      const err = await response.json()
      throw new Error(err)
    }
    this.assumptions = await response.json()
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

  async put_fav_data(flag:boolean,id:number){
    let idToken = null
    
     try{
     await Auth.currentSession()
      .then(data => {
        idToken = data.getIdToken().getJwtToken()
      })}catch(error){
        console.log(error)
        return
      } 

    const response=await axios.put('http://0.0.0.0:8000/like',{"flag":flag,"id":id},{
      headers: {
        "Authorization": idToken
      }
    }).then(data=>{
      console.log(data)
    })
  }

    //TODO　APIと通信してDBの情報を更新する。
  fav(index:number,id:number){
    if (this.flag[index]) {
      this.$set(this.flag,index,false)
      this.$set(this.animation,index,"")
      this.$set(this.animation,index,"background-position:left")
      this.put_fav_data(false,id)
    } else {
      this.$set(this.flag,index,true)
      this.$set(this.animation,index,"HeartAnimation")
      this.put_fav_data(true,id)
    }
  }

  async loginFlag(){
     this.signed_in = false
     await Auth.currentUserInfo()
    .then(data => this.signed_in = Boolean(data))
    .catch(err => console.log(err))
    console.log(this.signed_in)
    return this.signed_in
  }

  created() {
    this.AssumptionsFetch()
    this.loginFlag()
    this.getFavData()
  }
}
</script>

<style lang="scss" href="../../assets/css/style.scss"></style>
