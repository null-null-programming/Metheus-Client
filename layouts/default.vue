<template>
  <div>
    <nav
      class="navbar has-background-white"
      role="navigation"
      aria-label="main navigation"
    >
      <div class="title is-1 navbar-brand has-text-danger-dark unique-font">
        <NuxtLink class="navbar-item" :to="{ path: '/' }">
          Mehteus
        </NuxtLink>
      </div>

      <div id="metheusNavbar" class="navbar-menu">
        <div class="navbar-start title is-3">
          <NuxtLink
            class="navbar-item has-text-black-ter unique-font"
            :to="{ path: '/' }"
            >Home</NuxtLink
          >
          <NuxtLink
            class="navbar-item has-text-black-ter unique-font"
            :to="{ path: '/category' }"
            >Category</NuxtLink
          >
          <NuxtLink
            class="navbar-item has-text-black-ter unique-font"
            :to="{ path: '/request' }"
            >Request</NuxtLink
          >
        </div>
        <div class="navbar-end">
          <div class="navbar-item">
          </div>
        </div>
      </div>
    </nav>
    <Nuxt />
  </div>
</template>
<style lang="scss" href="../assets/css/style.scss"></style>
<script href="../assets/script/script.js"></script>

<script>
export default {
  name: 'default',
  
}
</script>