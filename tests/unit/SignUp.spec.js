import { shallowMount } from '@vue/test-utils'
import SignUp from './components/SignUp'

describe('SignUp', () => {
  test('is a Vue instance', () => {
    const wrapper = shallowMount(SignUp)
    expect(wrapper.isVueInstance()).toBeTruthy()
    expect(wrapper.element).toMatchSnapshot()
  })
})