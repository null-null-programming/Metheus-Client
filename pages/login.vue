<template>
  <div class="container">
    <button
      class="button is-info unique-font"
      type="primary"
      @click="loginWithAuthZero"
    >Login with Auth0</button>
  </div>
</template>

<script>
export default {
  methods: {
    loginWithAuthZero: function () {
      this.$auth.loginWith('auth0')
    }
  }
}
</script>