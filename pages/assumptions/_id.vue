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
import $ from 'jquery'

@Component({ name: 'Assumptions' })
export default class Assumptions extends Vue {
  articles: any = null
  id: string=this.$route.params.id.toString()
  //TODO MariaDB
  flag: Array<boolean> = [false,false,false,false,false,false,false,false,false]

  async AssumptionsFetch(id: number) {
    const response = await fetch(
      ' http://0.0.0.0:8000/assumptions/' + id.toString()
    )
    if (!response.ok) {
      const err = await response.json()
      throw new Error(err)
    }
    this.articles = await response.json()

    console.log('success!,get Articles!')
  }  

  
  fav(index:number){
    console.log('hello')
    let $btn = $("LikesIcon")
    if (this.flag[index]) {
      this.$set(this.flag,index,false)
      $btn.css("background-position","left");
    } else {
      this.$set(this.flag,index,true)
    }
    console.log(this.flag[index])
  }

  created() {
    //@ts-ignore
    this.AssumptionsFetch(this.$route.params.id)
  }

}
</script>

<style lang="scss" href="../../assets/css/style.scss"></style>
