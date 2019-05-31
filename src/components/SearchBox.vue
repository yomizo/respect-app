<template>
  <v-dialog
    v-model="dialog"
    max-width="600"
    persistent
    >
    <v-btn @click="closeSearchBox" 
      icon 
      color="pink accent-2"
      flat
      small>
      <v-icon>arrow_back</v-icon>
    </v-btn>
    <span class="font-weight-bold white--text">
      探したい地名を入力しよう！  
    </span>    
    <v-text-field
      v-model="searchWord"
      hide-details
      color="pink accent-4"
      class="grey darken-4"
      dark
      outline
      clearable
      append-icon="search"
      @click:append="searchLocation"
      >
    </v-text-field>
  </v-dialog>
</template>

<script>
export default {
  data() {
    return {
      searchWord: "",
    }
  },

  computed: {
    map: {
      get() { return this.$store.getters.map }
    },
    dialog: {
      get() { return this.$store.getters.dialog},
      set() { this.$store.commit('setDialog')}
    }
  },

  methods: {
    // search function with google
    searchLocation() {
      let request = {
        query: this.searchWord,
        fields: [ 'name', 'geometry']
      }
      let service = new google.maps.places.PlacesService(this.map)
      let vm = this
      // query search
      service.findPlaceFromQuery( request, function(results, status) {
        if ( status === google.maps.places.PlacesServiceStatus.OK ) {
          vm.map.setCenter( results[0].geometry.location)
          vm.closeSearchBox()
        } else {
          vm.$store.commit("updateFlash", "NOT FOUND")
          vm.$store.commit("updateIsSnackBar")
        }
      })
    },
    closeSearchBox() {
      this.$store.commit('updateDialog')
      this.$router.push('/')
    }
  }
}
</script>

<style>
.searchBox {
  max-width: 760px;
  opacity: 0.9;
}
</style>

