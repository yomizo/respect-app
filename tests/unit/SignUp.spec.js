import { shallowMount } from '@vue/test-utils'
import SignUp from '@/components/SignUp.vue'

describe('SignUp', () => {
  const wrapper = shallowMount(SignUp)

  it('is a Vue instance', () => {  
    expect(wrapper.isVueInstance()).toBeTruthy()
    expect(wrapper.element).toMatchSnapshot()
  })
})