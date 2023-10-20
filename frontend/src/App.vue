<script setup>
import HomePage from './components/HomePage.vue'
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
    <HomePage />
  </main>
</template>

<style>
</style>
