<template>
  <div class="hello">
    <h1>{{ msg }}</h1>
    <input type="button" id="btn1" value="Click Me" v-on:click="trackClick" />
  </div>
</template>

<script>
export default {
  name: 'HelloWorld',
  props: {
    msg: String
  },
  methods: {
    trackClick: () => {
      const request = {
        method: 'POST',
        headers: new Headers(),
        mode: 'cors',
        cache: 'default',
      }
      fetch('http://api.localhost:3000/track', request)
    }
  }
}
</script>

<!-- Add "scoped" attribute to limit CSS to this component only -->
<style scoped>
h3 {
  margin: 40px 0 0;
}
</style>
