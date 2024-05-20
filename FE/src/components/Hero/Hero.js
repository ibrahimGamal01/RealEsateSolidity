// HeroSection.js
import React from 'react'
import { Typography } from '@mui/material'
import { styled } from '@mui/system'
import { GradientCircle, HeroContainer, HeroImage, ImageContainer, ListingsSoldContainer, StatBox, StatLabel, StatNumber, TextContainer, WhiteGradient } from './HeroStyles'
// import heroImage from '../../public/heroImage.jpg' // replace with your image path


const Hero = () => {
  return (
    <HeroContainer>
      <TextContainer>
        <GradientCircle />
        <WhiteGradient/>
        <Typography variant="h2" gutterBottom>
          Welcome to Our Website
        </Typography>
        <Typography variant="h6" paragraph>
          Discover amazing content and join our community. We provide the best resources to help you succeed.
        </Typography>
        <ListingsSoldContainer>
          <StatBox>
            <StatNumber>200 +</StatNumber>
            <StatLabel>Listings</StatLabel>
          </StatBox>
          <StatBox>
            <StatNumber>100 +</StatNumber>
            <StatLabel>Sold</StatLabel>
          </StatBox>
        </ListingsSoldContainer>
      </TextContainer>
      <ImageContainer>
        <HeroImage src={'/heroImage.jpg'} alt="Hero" />
      </ImageContainer>
    </HeroContainer>
  )
}

export default Hero
