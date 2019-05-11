<template>
  <div class="text-xs-center">
    <v-menu
      v-model="menu"
      :close-on-content-click="false"
    >
      <template v-slot:activator="{ on }">
        <v-btn
          color="pink accent-2"
          fab
          dark
          v-on="on"
          @click="getUser"
        >
          <v-icon>mdi-menu-open</v-icon>
        </v-btn>
      </template>

      <v-card dark>
<!-- USER DATA         -->
        <v-list class="pa-1">
          <v-list-tile avatar tag="div">
            <v-list-tile-avatar>
              <img :src="userImage">
            </v-list-tile-avatar>

            <v-list-tile-content>
              <v-list-tile-title>{{userName}}</v-list-tile-title>
            </v-list-tile-content>

            <v-list-tile-action>
              <v-btn icon @click="closeMenu">
                <v-icon>chevron_right</v-icon>
              </v-btn>
            </v-list-tile-action>
          </v-list-tile>
        </v-list>
        <v-divider light></v-divider>
<!-- ALL USER         -->
        <v-list class="pt-0" dense>
          <v-list-tile
            @click="showMap"
            dark
            >
            <v-list-tile-action>
              <v-icon>mdi-google-maps</v-icon>
            </v-list-tile-action>
            <v-list-tile-content>
              <v-list-tile-title>Map</v-list-tile-title>
            </v-list-tile-content>
          </v-list-tile>
          <v-list-tile
            @click="showAbout"
            dark
            >
            <v-list-tile-action>
              <v-icon>mdi-information</v-icon>
            </v-list-tile-action>
            <v-list-tile-content>
              <v-list-tile-title>About</v-list-tile-title>
            </v-list-tile-content>
          </v-list-tile>          
        </v-list>
<!-- USER         -->
        <v-list class="pt-0" dense v-if="user">
          <v-list-tile
            @click="showMyPage"
            dark
            >
            <v-list-tile-action>
              <v-icon>mdi-settings</v-icon>
            </v-list-tile-action>
            <v-list-tile-content>
              <v-list-tile-title>MyPage</v-list-tile-title>
            </v-list-tile-content>
          </v-list-tile>
          <v-list-tile
            @click="logout"
            dark
            >
            <v-list-tile-action>
              <v-icon>mdi-logout</v-icon>
            </v-list-tile-action>
            <v-list-tile-content>
              <v-list-tile-title>LogOut</v-list-tile-title>
            </v-list-tile-content>
          </v-list-tile>          
        </v-list>
<!-- GUESST         -->
        <v-list class="pt-0" dense v-else>
          <v-list-tile
            @click="showSignUp"
            dark
            >
            <v-list-tile-action>
              <v-icon>mdi-account-plus</v-icon>
            </v-list-tile-action>
            <v-list-tile-content>
              <v-list-tile-title>SignUp</v-list-tile-title>
            </v-list-tile-content>
          </v-list-tile>
          <v-list-tile
            @click="showSignIn"
            dark
            >
            <v-list-tile-action>
              <v-icon>mdi-login</v-icon>
            </v-list-tile-action>
            <v-list-tile-content>
              <v-list-tile-title>SignIn</v-list-tile-title>
            </v-list-tile-content>
          </v-list-tile>          
        </v-list>               
      </v-card>
    </v-menu>
  </div>
</template>

<script>
  export default {
    data: () => ({
      fav: true,
      menu: false,
      message: false,
      hints: true,
      items: [
        { title: 'Map', icon: 'mdi-google-maps' },
        { title: 'SignUp', icon: 'mdi-account-plus' },
        { title: 'SignIn', icon: 'mdi-login' },
        { title: 'About', icon: 'mdi-information' },
        { title: 'LogOut', icon: 'mdi-logout' },
      ],
      userName: "GUESST",
      userImage: "default_icon.png"  
    }),

    computed:{
      user: { get(){ return this.$store.getters.userData }}, 
    },

    methods: {
      closeMenu() {
        this.menu = false
      },
      getUser() {
        if(this.user) {
          this.userName = this.user.name
          this.userImage = this.user.image
        }
      },
      showAbout() {
        //
      },
      showMap() {
        this.$router.push("/")
        this.closeMenu()
      },
      showSignUp() {
        this.$router.push("/signup")
        this.closeMenu()
      },
      showSignIn() {
        this.$router.push("/signin")
        this.closeMenu()
      },            
      showMyPage() {
        this.$store.dispatch('showUser', "/users/")
        this.closeMenu()
      },
      logout() {
        this.$store.commit('updateToken', {token: null})
        this.$store.commit('updateUserId', {userId: null})
        this.$store.commit('updateUserData', null)
        this.$store.commit('updateFlash', "ログオフしました")
        this.$store.commit('updateIsSnackBar')
        this.$store.commit('updateSnackBarColor', {color: "#FF1744"})
        this.closeMenu()
      },      
    },
  }
</script>

<style>


</style>
