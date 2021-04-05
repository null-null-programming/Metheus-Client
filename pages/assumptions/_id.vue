<template>
  <div>
    <div class="container padding-top">
      <div class="has-text-right">
        <button class="button is-info unique-font">
          <NuxtLink class="has-text-white" :to="{ path: '/den/'+id }"
            >write</NuxtLink
          >
        </button>
      </div>
    </div>
    <div class="container">
      <ul id="articles_title">
        <li v-for="article in articles" v-bind:key="article.id">
          <div class="tile is-ancestor is-primary padding-top">
            <article class="tile is-child notification is-dark">
              <NuxtLink
                class="title is-3 unique-font padding-top"
                key="title"
                :to="{ path: '/articles/' + article.id }"
                >{{ article.title }}</NuxtLink
              >
            </article>
          </div>
        </li>
      </ul>
    </div>
  </div>
</template>

<script lang="ts">
import { Component, Vue } from 'nuxt-property-decorator'
import axios from 'axios'

@Component({ name: 'Assumptions' })
export default class Assumptions extends Vue {
  articles: any = null
  id: string=this.$route.params.id.toString()

  async AssumptionsFetch(id: number) {
    const response = await fetch(
      'http://127.0.0.1:8000/assumptions/' + id.toString()
    )
    if (!response.ok) {
      const err = await response.json()
      throw new Error(err)
    }
    this.articles = await response.json()

    console.log('success!,get Articles!')
  }  

  created() {
    //@ts-ignore
    this.AssumptionsFetch(this.$route.params.id)
  }

}
</script>

<style lang="scss" href="../../assets/css/style.scss"></style>
