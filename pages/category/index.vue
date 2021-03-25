<template>
  <div>
    <div class="container">
      <h1 class="title is-1 unique-font padding-top">Category</h1>
    </div>
    <div class="container">
      <ul id="categoryTitle">
        <li v-for="category in categories" v-bind:key="category.id">
          <div class="tile is-ancestor is-primary padding-top">
            <article class="tile is-child notification is-dark">
              <NuxtLink
                class="tile is-2 unique-font"
                :to="{path : '/category/'+category.id}"
              >{{ category.name }}</NuxtLink>
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

@Component({ name: 'CategoryList' })
export default class CategoryList extends Vue {
  categories: any = null

  async Fetch() {
    const response = await fetch('http://127.0.0.1:8000/category')
    if (!response.ok) {
      const err = await response.json()
      throw new Error(err)
    }
    this.categories = await response.json()
    console.log('success!')
  }

  created() {
    console.log('categories:' + this.categories)
    this.Fetch()
  }
}
</script>

<style lang="scss" href="../../assets/css/style.scss"></style>
