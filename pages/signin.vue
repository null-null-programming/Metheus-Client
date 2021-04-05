<template>
 <div class="container">
   <div>
      <h1 class="title is-1 unique-font padding-top">Metheus</h1>
      <h1 class="subtitle is-4 unique-font padding-left">If it is true...</h1>
    </div>
      <div>
        <amplify-authenticator>
        </amplify-authenticator>
      </div>
 </div>
</template>

<script>
export default {
  name: 'login',
  layout:'not_default'
}
</script>

<style lang="scss" href="../assets/css/style.scss"></style>
