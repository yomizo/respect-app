<template>
  <v-list class="sidebar grey ligthen-4" two-line>
    <template v-for="(post, index) in markerList" >
      <v-list-tile
        :key="index"
        avatar
        class="tile blue-grey lighten-5" 
        @click="showPost(post)"
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
  computed: {
    markerList: {
      get() { return this.$store.getters.markerList}
    },
    map: {
      get() { return this.$store.getters.map}
    },    
  },

  methods: {
    showPost(post) {
      let latLng = new google.maps.LatLng(post.lat, post.lng)
      let postData = this.markerList.filter(function(item, i){
        let storedLatLng = new google.maps.LatLng(item.lat, item.lng, false)
        if (storedLatLng.equals(latLng)) return true
      })
      this.$store.dispatch('setPostData', "/posts/" + postData[0].id)
      this.map.panTo(latLng)
    }
  }
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

