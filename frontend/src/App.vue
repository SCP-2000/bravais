<script setup>
import HelloWorld from './components/HelloWorld.vue'
import TheWelcome from './components/TheWelcome.vue'

</script>

<script>
export default {
    mounted() {
      let govukjs = document.createElement('script')
      govukjs.setAttribute('src', '/src/govuk.js')
      document.head.appendChild(govukjs)

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
