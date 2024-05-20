import { Box, Typography } from '@mui/material'
import React from 'react'
import { styled } from 'styled-components'



const Footer = () => {
  return (
    <Box margin='auto' px={20} pb={20} >
        <Box display='flex' justifyContent='space-between'>
        <Box>
            <img src='./logo2.png' alt='logo' width={120}/>

            <Typography mt={2} color='rgb(140, 139, 139)'>Our vision is to make all people <br/> the best place to live for them.</Typography>
        </Box>
        <Box>
            <Typography variant='h4' fontWeight={700} color='#1f3e72'>Information</Typography>
            <Typography color='rgb(140, 139, 139)'>145 New Borg El-Arab City, Alexandria</Typography>
            <Box display='flex' gap={3} mt={2}>
            <Typography fontWeight={500}>Properties</Typography>
            <Typography fontWeight={500}>About</Typography>
            <Typography fontWeight={500}>Get Started</Typography>
            <Typography fontWeight={500}>Services</Typography>
            </Box>
        </Box>
        </Box>
    </Box>
  )
}

export default Footer