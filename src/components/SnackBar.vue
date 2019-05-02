<template>
  <v-snackbar
    v-model="isSnackBar"
    top
    :color="snackBarColor"
    auto-height
    >
    {{flash}}
  </v-snackbar>
</template>


<script>
export default {
  computed: {
    isSnackBar: {
      get() { return this.$store.getters.isSnackBar },
      set() {this.$store.commit('updateIsSnackBar')}
    },
    flash: {
      get() { return this.$store.getters.flash }
    },
    snackBarColor: {
      get() { return this.$store.getters.snackBarColor }
    }
  },
}
</script>
