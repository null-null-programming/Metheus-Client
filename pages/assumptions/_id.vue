<template>
    <div class="container padding-top">
      <div>
        <button class="button is-danger unique-font">
          <NuxtLink class="title is-2 has-text-white" :to="{ path :'/category'}">
            Back
          </NuxtLink>
        </button>
          <button class="button is-primary unique-font">
            <NuxtLink class="title is-2 has-text-white" :to="{ path: '/den/'+id }"
              >write</NuxtLink
            >
          </button>
        </div>
    <div class="container">
      <ul id="articles_title">
        <li v-for="article in articles" v-bind:key="article.id">
          <div class="columns padding-top">
          <div class="colum tile is-ancestor is-primary padding-top pcs-width">
            <article class="tile is-child notification is-white">
              <NuxtLink
                class="title is-3 unique-font padding-top"
                key="title"
                :to="{ path: '/articles/' + article.id }"
                >{{ article.title }}</NuxtLink
              >
            </article>
            </div>
          <div class="colum" style="padding-left:30px;" >
              <div class="Likes" v-if="articles.length>1">
                <div class="Likes-Icon"  @click="fav()"></div>
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

  fav(){
    let $btn = $(".Likes-Icon")
    if ($btn.hasClass('on')) {
      $btn.removeClass('on');
      $btn.removeClass("HeartAnimation");
      $btn.css("background-position","left");
    } else {
      $btn.addClass('on');
      $btn.addClass("HeartAnimation");
    }
  }

  created() {
    //@ts-ignore
    this.AssumptionsFetch(this.$route.params.id)
  }

}
</script>

<style lang="scss" href="../../assets/css/style.scss"></style>
