import { Box } from '@mui/material'
import React from 'react'

const Companies = () => {
  return (
    <Box>
        <Box sx={{justifyContent: 'space-around', gap: '1rem', display: 'flex'}} mt={5}>
            <img width={150} src='./prologis.png' alt='logo'/>
            <img width={150} src='./tower.png' alt='logo'/>
            <img width={150} src='./equinix.png' alt='logo'/>
            <img width={150} src='./realty.png' alt='logo'/>
        </Box>
        
        </Box>
  )
}

export default Companies