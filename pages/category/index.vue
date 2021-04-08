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
                <div class="{index}"  @click="fav(category.id)"></div>
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
import $ from 'jquery';

@Component({ name: 'CategoryList' })
export default class CategoryList extends Vue {
  categories: any = null

  async Fetch() {
    const response = await fetch('http://0.0.0.0:8000/category')
    if (!response.ok) {
      const err = await response.json()
      throw new Error(err)
    }
    this.categories = await response.json()
    console.log('success!')
  }

  fav(index:string){
    let $btn = $("."+index)
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
    console.log('categories:' + this.categories)
    this.Fetch()
  }
}
</script>

<style lang="scss" href="../../assets/css/style.scss"></style>
