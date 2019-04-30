<template>
  <v-container fluid pa-0>
    <v-layout row>
      <v-flex class="hidden-md-and-down" lg3>
        <PostsIndex/>
      </v-flex>
      <v-flex>
        <Gmap/>
      </v-flex>
    </v-layout>
    <router-view></router-view>
  </v-container>
</template>


<script>
import Gmap from './Gmap'
import PostsIndex from './PostsIndex'

export default {
  components: {
    Gmap, PostsIndex
  }
}
</script>

