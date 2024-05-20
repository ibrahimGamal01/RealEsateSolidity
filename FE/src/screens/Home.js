import React from 'react'
import Layout from '../layout/Layout'
import Hero from '../components/Hero/Hero'
import Companies from '../components/Companies/Companies'
import Properties from '../components/Properties/Properties'

const Home = () => {

  return (
    <Layout>
      <Hero/>
      <Companies/>
      <Properties/>
    </Layout>
  )
}

export default Home