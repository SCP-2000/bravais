<script setup>
import HelloWorld from './components/HelloWorld.vue'
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
  </main>
</template>

<style scoped>

</style>
