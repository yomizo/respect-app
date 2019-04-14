<template>
  <v-app>
    <Toolbar/>
    <Gmap/>
    <Modal/>
  </v-app>
</template>

<script>
import Gmap from './components/Gmap'
import Toolbar from './components/ToolBar'
import Modal from './components/Modal'

export default {
  name: 'App',
  components: {
    Gmap,
    Toolbar,
    Modal
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
