<template>
  <div class="container padding-top">
      <ul id="assumptions_title">
        <li v-for="assumption in assumptions" v-bind:key="assumption.id">
          <div class="tile is-ancestor is-primary padding-top">
            <article class="tile is-child notification is-dark">
              <NuxtLink
                class="title is-2 unique-font padding-top"
                key="title"
                :to="{ path: '/assumptions/' + assumption.id }"
                >{{ assumption.title }}</NuxtLink
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
import 'vue-router'
import axios from 'axios'

@Component({ name: 'Assumptions' })
export default class Assumptions extends Vue {
  assumptions: any = null
  id: string = this.$route.params.id

  async AssumptionsFetch() {
    const response = await fetch('http://0.0.0.0:8000/category/' + this.id)
    if (!response.ok) {
      const err = await response.json()
      throw new Error(err)
    }
    this.assumptions = await response.json()

    console.log('success!,get Assumptions!')
  }

  created() {
    this.AssumptionsFetch()
  }
}
</script>

<style lang="scss" href="../../assets/css/style.scss"></style>
