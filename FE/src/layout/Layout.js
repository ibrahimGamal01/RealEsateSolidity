// will add layout components later

import React from 'react'
import NavbarSection from './Navbar'
import Navbar from './Navbar'
import Footer from './Footer'

const Layout = ({children, navbarClass, isWhiteBackground, isUserButton}) => {
  return (
    <div style={isWhiteBackground?{ background: '#FFF'} : {background: '#F1F1F1'}}>
      <Navbar />
        {children}
        <Footer/>
    </div>  
  )
}

export default Layout