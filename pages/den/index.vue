<template>
  <div class="container padding-top">
    <div class="columns">
      <div class="column">
        <input class="input is-info" type="text" placeholder="タイトル" />
      </div>
      <div class="column">
        <button class="button is-danger unique-font">Submit</button>
      </div>
    </div>
    <div class="columns padding-top">
      <div class="field column">
        <div class="control">
          <textarea class="textarea form-height" placeholder="本文" v-model="data"></textarea>
        </div>
      </div>
      <div class="field column">
        <div v-html="$md.render(data)"></div>
      </div>
    </div>
  </div>
</template>

<script lang="ts">
import Vue from 'vue'
import { Provide, Model, Component } from 'nuxt-property-decorator'

@Component
export default class den extends Vue {
  name: 'den'
  data: string =
    '# 正規分布です。 \n  $f(x) = \\frac{1}{\\sqrt {2\\pi \\sigma^2}} \\exp\\Biggl(-\\frac{(x-\\mu)^2}{2\\sigma^2}\\Biggr) \\qquad (-\\infty<x<\\infty)$'
}
</script>