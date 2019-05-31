<template>
  <v-content class="blue-grey lighten-5">
    <v-container class="formx">
      <v-card class="opacity grey darken-4 pa-2">
        <v-container>
          <div class="white--text headline font-weight-bold">SignIn</div>
          <form>
            <v-text-field
              dark
              color="pink accent-2"
              v-model="email"
              v-validate="'required|email'"
              :error-messages="errors.collect('email')"
              label="E-mail"
              data-vv-name="email"
              required
            ></v-text-field>
            <v-text-field
              dark
              color="pink accent-2"            
              v-model="password"
              v-validate="'required'" 
              name="password" 
              type="password" 
              :class="{'is-danger': errors.has('password')}" 
              placeholder="Password" 
              ref="password"></v-text-field>
            <div class="text-xs-right">
              <v-btn dark color="pink accent-2" @click="submit">submit</v-btn>
              <v-btn dark color="pink accent-2" @click="clear">clear</v-btn>
            </div>
          </form>
        </v-container>
      </v-card>
    </v-container>
  </v-content>
</template>

<script>
import Vue from 'vue'
import VeeValidate from 'vee-validate'

Vue.use(VeeValidate)

export default {
  $_veeValidate: {
    validator: 'new'
  },

  data: () => ({
    email: '',
    password: '',
    dictionary: {
      attributes: {
        email: 'E-mail Address'
        // custom attributes
      },
      custom: {
        name: {
          required: () => 'Name can not be empty',
          max: 'The name field may not be greater than 10 characters'
          // custom messages
        },
      }
    }
  }),

  mounted () {
    this.$validator.localize('en', this.dictionary)
  },

  methods: {
    submit () {
      var judge
      this.$validator.validateAll().then((result) => {
        if(!result) {
          alert(this.errors.all())
          return
        }
        this.postUser()
      })
    },
    clear () {
      this.email = ''
      this.password = ''
      this.$validator.reset()
    },
    postUser() {
      var params = {
        email: this.email, 
        password: this.password
        }
      this.$store.dispatch('signin', ['/signin', params])
    }
  }
}
</script>

<style>
.formx {
  max-width: 768px
}

.opacity {
  opacity: 0.9;
}
</style>
