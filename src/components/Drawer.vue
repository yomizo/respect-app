<template>
  <v-navigation-drawer
    v-model="navDrawer"
    absolute
    dark
    temporary
    right
    
  >
    <v-list class="pa-1">
      <v-list-tile avatar tag="div">
        <v-list-tile-avatar>
          <img src="default_icon.png">
        </v-list-tile-avatar>

        <v-list-tile-content>
          <v-list-tile-title>{{userName}}</v-list-tile-title>
        </v-list-tile-content>

        <v-list-tile-action>
          <v-btn icon @click="closeDrawer">
            <v-icon>chevron_right</v-icon>
          </v-btn>
        </v-list-tile-action>
      </v-list-tile>
    </v-list>

    <v-list class="pt-0" dense>
      <v-divider light></v-divider>

      <v-list-tile
        v-for="item in items"
        :key="item.title"
        @click=""
      >
        <v-list-tile-action>
          <v-icon>{{ item.icon }}</v-icon>
        </v-list-tile-action>

        <v-list-tile-content>
          <v-list-tile-title>{{ item.title }}</v-list-tile-title>
        </v-list-tile-content>
      </v-list-tile>
    </v-list>
  </v-navigation-drawer>
</template>

<script>
export default {
  data () {
    return {
      items: [
        { title: 'Map', icon: 'mdi-google-maps' },
        { title: 'SignUp', icon: 'mdi-account-plus' },
        { title: 'SignIn', icon: 'mdi-login' },
        { title: 'About', icon: 'mdi-information' },
        { title: 'LogOut', icon: 'mdi-logout' },
      ],
      userName: "GUESST"
    }
  },

  computed: {
    user: {
      get(){ return this.$store.getters.userData }
    },
    navDrawer: {
      get() { return this.$store.getters.navDrawer },
      set() { this.$store.commit('updateNavDrawer')}
    }
  },

  methods: {
    closeDrawer() {
      this.$store.commit('updateNavDrawer')
    }
  }
}
</script>