<template>
  <v-app>
    <Toolbar/>
    <router-view></router-view>
    <SnackBar></SnackBar>
  </v-app>
</template>

<script>
import Toolbar from './components/ToolBar'
import SnackBar from './components/SnackBar'


export default {
  name: 'App',
  components: {
    Toolbar,
    SnackBar,
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
