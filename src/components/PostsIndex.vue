<template>
  <v-list two-line>
    <template v-for="(post, index) in searchList">
      <!-- <v-subheader
        v-if="item.header"
        :key="item.header"
      >
        {{ item.header }}
      </v-subheader> -->

      <v-divider></v-divider>

      <v-list-tile
        
        :key="post.id"
        avatar
        @click=""
      >
        <v-list-tile-avatar>
          <img :src="require('../assets/yomizou_face.png')">
        </v-list-tile-avatar>

        <v-list-tile-content>
          <v-list-tile-title v-html="post.respect"></v-list-tile-title>
          <v-list-tile-sub-title v-html="post.comment"></v-list-tile-sub-title>
        </v-list-tile-content>
      </v-list-tile>
    </template>
  </v-list>
</template>


<script>
  export default {
    data () {
      return {
        items: [
          { header: 'Today' },
          {
            avatar: 'https://cdn.vuetifyjs.com/images/lists/1.jpg',
            title: 'Brunch this weekend?',
            subtitle: "<span class='text--primary'>Ali Connors</span> &mdash; I'll be in your neighborhood doing errands this weekend. Do you want to hang out?"
          },
          { divider: true, inset: true },
          {
            avatar: 'https://cdn.vuetifyjs.com/images/lists/2.jpg',
            title: 'Summer BBQ <span class="grey--text text--lighten-1">4</span>',
            subtitle: "<span class='text--primary'>to Alex, Scott, Jennifer</span> &mdash; Wish I could come, but I'm out of town this weekend."
          },
          { divider: true, inset: true },
          {
            avatar: 'https://cdn.vuetifyjs.com/images/lists/3.jpg',
            title: 'Oui oui',
            subtitle: "<span class='text--primary'>Sandra Adams</span> &mdash; Do you have Paris recommendations? Have you ever been?"
          }
        ]
      }
    },
    computed: {
      searchList: {
        get() { return this.$store.getters.searchList}
      }
    },
  }
</script>
