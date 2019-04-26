<template>
  <v-container fluid px-0 py-2>
    <v-layout row>
      <v-flex class="hidden-md-and-down" lg3 py-5>
        <PostsIndex/>
      </v-flex>
      <v-flex>
        <Gmap/>
      </v-flex>
    </v-layout>
    <!-- <PostModal/> -->
    <router-view></router-view>
  </v-container>
</template>


<script>
import Gmap from './Gmap'
import PostsIndex from './PostsIndex'
import PostModal from './Modal'

export default {
  components: {
    Gmap, PostsIndex, PostModal
  }
}
</script>

