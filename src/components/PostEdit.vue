<template>
  <v-layout row justify-center >
    <v-dialog
      v-model="dialog"
      max-width="290"
      persistent
    >
      <v-card dark class="opacity grey darken-4 pa-2">
        <v-card-actions>
          <v-btn
            to="/postshow" 
            icon 
            color="pink accent-2"
            flat
            small>
            <v-icon>arrow_back</v-icon>
          </v-btn>
          <v-spacer></v-spacer>          
        </v-card-actions>
        <v-card-text class="title text-xs-center white--text">
          Commentを編集する
        </v-card-text>

        <v-card-text class="text-xs-center">
          <v-avatar size="36">
            <img :src="postData.image" alt="avatar">
          </v-avatar>
          {{postData.user_name}}
        </v-card-text>
        <v-textarea 
          v-model="comment"
          label="Comment"
          outline
          auto-grow
          counter=140
          color="pink lighten-5"
          dark
          ></v-textarea>
        <v-card-text class="text-xs-center">
          <v-btn
            round
            dark
            fab
            color="pink accent-2"
            @click="editPost"
          >
           <v-icon>check</v-icon>
          </v-btn>
        </v-card-text>
      </v-card>
    </v-dialog>
  </v-layout>
</template>

<script>
export default {
  data () {
    return {
      comment: '',
    }
  },

  computed: {
    // defined vuex(store) variable
    postData: {
      get() { return this.$store.getters.postData }
    },
    dialog: {
      get() { return this.$store.getters.dialog },
      set() { this.$store.dispatch('setDialog') }
    },    
  },

  methods: {
    editPost() {
      let url = '/posts/' + this.postData.id
      console.log(url)
      this.$store.dispatch('editPost', [url, this.comment])
    }
  },

  created() {
    this.comment = this.postData.comment
  },
}
</script>

<style>
.opacity {
  opacity: 0.9;
}
</style>

