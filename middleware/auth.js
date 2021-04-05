import { Auth } from 'aws-amplify'
import { Component, Vue } from 'nuxt-property-decorator'

export default async ({redirect}) => {
  const userInfo = await Auth.currentUserInfo()

  if(!userInfo){
    //@ts-ignore
    await window.onNuxtReady(() => { window.$nuxt.$router.push('/signin') })
  }
}