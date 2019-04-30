<template>
  <v-list two-line>
    <template v-for="(post, index) in markerList">
      <v-list-tile
        :key="index"
        avatar
        
      >
        <v-list-tile-avatar>
          <img :src="require('../assets/yomizou_face.png')">
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
