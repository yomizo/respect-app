<template>
  <v-list class="sidebar grey ligthen-4" two-line>
    <template v-for="(post, index) in markerList" >
      <v-list-tile
        :key="index"
        avatar
        class="tile blue-grey lighten-5" 
      >
        <v-list-tile-avatar v-if="post.image">
          <img :src="post.image">
        </v-list-tile-avatar>
        <v-list-tile-avatar v-else>
          <img src="default_icon.png">
        </v-list-tile-avatar>
        <v-list-tile-content>
          <v-list-tile-title v-html="post.respect"></v-list-tile-title>
          <v-list-tile-sub-title v-html="post.comment"></v-list-tile-sub-title>
        </v-list-tile-content>
      </v-list-tile>
      <v-divider></v-divider>
    </template>
  </v-list>
</template>


<script>
  export default {
    data () {
      return {
        
      }
    },

    //
    computed: {
      markerList: {
        get() { return this.$store.getters.markerList}
      }
    },
  }
</script>

<style>
.sidebar {
  height: 100vh;
  overflow-y: scroll;
  padding-top: 60px;
}
.v-list {
  padding-top: 0px;
}
</style>

