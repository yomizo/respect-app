<template>
  <v-app>
    <Toolbar/>
    <!-- <v-layout row>
      <v-flex class="hidden-md-and-down" lg3 pa-2 pt-5>
        <PostsIndex/>
      </v-flex>
      <v-flex>
        <Gmap/>
      </v-flex>
    </v-layout> -->
    <Modal/>
    <router-view></router-view>
  </v-app>
</template>

<script>
import Gmap from './components/Gmap'
import Toolbar from './components/ToolBar'
import Modal from './components/Modal'
import PostsIndex from './components/PostsIndex'

export default {
  name: 'App',
  components: {
    Gmap,
    Toolbar,
    Modal,
    PostsIndex
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
