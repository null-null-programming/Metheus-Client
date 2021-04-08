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

@Component({ name: 'Assumptions' })
export default class Assumptions extends Vue {
  assumptions: any = null
  id: string = this.$route.params.id

  //TODO MariaDB
  flag: Array<boolean> = [false,false,false,false,false,false,false,false,false]
  async AssumptionsFetch() {
    const response = await fetch('http://0.0.0.0:8000/category/' + this.id)
    if (!response.ok) {
      const err = await response.json()
      throw new Error(err)
    }
    this.assumptions = await response.json()

    console.log('success!,get Assumptions!')
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
    this.AssumptionsFetch()
  }
}
</script>

<style lang="scss" href="../../assets/css/style.scss"></style>
