<template>
  <v-app>
    <Toolbar/>
    <router-view></router-view>
  </v-app>
</template>

<script>
import Toolbar from './components/ToolBar'

export default {
  name: 'App',
  components: {
    Toolbar,
  },
  data () {
    return {
      //
    }
  },
}
</script>

<style>
html, body{
  padding: 0;
  margin: 0;
}
</style>
