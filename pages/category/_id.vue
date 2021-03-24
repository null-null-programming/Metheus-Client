<template>
  <div>
    <div class="container">
      <ul id="assumptions_title">
        <li v-for="assumption in assumptions" v-bind:key="assumption.id">
          <div class="tile is-ancestor is-primary padding-top">
            <article class="tile is-child notification is-dark">
              <NuxtLink
                class="title is-3 unique-font padding-top"
                key="title"
                :to="{path: '/assumptions/'+id}"
              >{{assumption.title}}</NuxtLink>
            </article>
          </div>
        </li>
      </ul>
    </div>
  </div>
</template>
      
<script lang = "ts" >
import { Component, Vue } from 'nuxt-property-decorator'
import axios from 'axios'

@Component({ name: 'Assumptions' })
export default class Assumptions extends Vue {
  id: number = 0
  assumptions: any = null

  async AssumptionsFetch(id: number) {
    const response = await fetch(
      'http://127.0.0.1:8000/category/' + id.toString()
    )
    if (!response.ok) {
      const err = await response.json()
      throw new Error(err)
    }
    this.assumptions = await response.json()

    console.log('success!,get Assumptions!')
  }

  created() {
    //@ts-ignore
    this.AssumptionsFetch(this.$route.params.id)
  }
}
</script>


  <style lang = "scss" href = "../../assets/css/style.scss" >
</style>