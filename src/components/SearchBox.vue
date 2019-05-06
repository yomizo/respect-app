<template>
  <v-toolbar
    color="grey darken-4"
    dark class="searchBox"
    dense
    fixed
    app
    >
    <v-text-field
      v-model="searchWord"
      hide-details
      color="pink accent-4"
      >
    </v-text-field>
    <v-btn icon 
      @click="searchLocation">
      <v-icon>search</v-icon>
    </v-btn>
  </v-toolbar>  
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
    }
  },
  methods: {
    searchLocation() {
      let request = {
        query: this.searchWord,
        fields: [ 'name', 'geometry']
      }
      let service = new google.maps.places.PlacesService(this.map)
      let vm = this
      service.findPlaceFromQuery( request, function(results, status) {
        if ( status === google.maps.places.PlacesServiceStatus.OK ) {
          vm.map.setCenter( results[0].geometry.location)
        }
      })
    }
  }
}
</script>

<style>
.searchBox {
  width: 350px;
  border-radius: 20px;
}
</style>

