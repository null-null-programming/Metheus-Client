<template>
  <div class="container padding-top">
    <div>
      <h1 class="title is-1 unique-font padding-top">Metheus</h1>
      <h1 class="subtitle is-4 unique-font padding-left">If it is true...</h1>
    </div>
    <div>
      <div class="Likes">
        <div class="Likes-Icon" @click="fav()"></div>
      </div>
    </div>
  </div>
</template>

<style lang="scss" href="../assets/css/style.scss"></style>
<script lang="ts">
import { Component, Vue } from 'nuxt-property-decorator'
import $ from 'jquery';

@Component
export default class pageHome extends Vue {
  name: 'pageHome'

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

}
</script>