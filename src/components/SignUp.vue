<template>
  <v-content class="blue-grey lighten-5">
    <v-container class="formx">
      <v-card class="opacity grey darken-4 pa-2">
        <v-container>
          <v-card-text class="headline white--text font-weight-bold">SignUp</v-card-text>
          <form>
            <v-text-field
              dark
              color="pink accent-2"
              v-model="name"
              v-validate="'required|max:10'"
              :counter="10"
              :error-messages="errors.collect('name')"
              label="Name"
              data-vv-name="name"
              required
            ></v-text-field>
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
    name: '',
    email: '',
    password: '',
    // flash_message_dic
    dictionary: {
      attributes: {
        email: 'E-mail Address'
      },
      custom: {
        name: {
          required: () => 'Name can not be empty',
          max: 'The name field may not be greater than 10 characters'
          // custom messages
        },
        select: {
          required: 'Select field is required'
        }
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
        this.registerUser()
      })
    },
    clear () {
      this.name = ''
      this.email = ''
      this.password = ''
      this.$validator.reset()
    },
    registerUser() {
      var params = {
        name: this.name, 
        email: this.email, 
        password: this.password
        }
      this.$store.dispatch('signup', ['/users', params])
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
