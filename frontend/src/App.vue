<script setup>
import HelloWorld from './components/HelloWorld.vue'
import TheWelcome from './components/TheWelcome.vue'

</script>

<script>
export default {
  mounted() {
    window.GOVUKFrontend.initAll()
  }
}
</script>

<template>
  <main>
    <HelloWorld msg="You did it!" />
    <TheWelcome />
  </main>
</template>

<style scoped>

</style>
