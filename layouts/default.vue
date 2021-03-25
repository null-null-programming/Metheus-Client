<template>
  <div>
    <nav class="navbar has-background-dark" role="navigation" aria-label="main navigation">
      <div class="navbar-brand">
        <NuxtLink class="navbar-item" :to="{ path: '/' }">
          <img src="../assets/static/apple.png" width="40" height="40" />
        </NuxtLink>
      </div>

      <div id="metheusNavbar" class="navbar-menu">
        <div class="navbar-start">
          <NuxtLink class="navbar-item has-text-light unique-font" :to="{ path: '/' }">Home</NuxtLink>
          <NuxtLink
            class="navbar-item has-text-light unique-font"
            :to="{ path: '/category' }"
          >Category</NuxtLink>
          <NuxtLink
            class="navbar-item has-text-light unique-font"
            :to="{ path: '/request' }"
          >Request</NuxtLink>
        </div>
        <div class="navbar-end">
          <div class="navbar-item">
            <div class="buttons">
              <a class="button is-danger unique-font">
                <nuxt-link class="has-text-light unique-font" :to="{path:'/login'}">Login</nuxt-link>
              </a>
            </div>
          </div>
        </div>
      </div>
    </nav>
    <Nuxt />
  </div>
</template>
<style lang="scss" href="../assets/css/style.scss"></style>

<script>
  export default {
    name: 'default'
  }
</script>