import React, { useEffect, useState } from 'react'
import 'swiper/css'
import data from './../../slider.json'
import { Box, Button, Typography } from '@mui/material'
import {Swiper, SwiperSlide, useSwiper} from 'swiper/react'
import { CardContainer, CustomButton, Details, ImageContainer, NameText } from './PropertiesStyles'
import { sliderSettings } from '../../Helpers/common'
import contract from '../../Helpers/contract'

const Properties = () => {
    const [listings, setListings] = useState([]);

  useEffect(() => {
    async function getListings() {
      const totalSupply = await contract.methods.totalSupply().call();
      const newlistings = [];
        console.log(totalSupply)
      for (let i = 0; i < totalSupply; i++) {
        const listing = await contract.methods.listings(i).call();
        newlistings.push(listing);
      }

      setListings(newlistings);
    }

    getListings();
  }, []);
  return (
    <div id='properties'>
    <Box px={10} py={15}>
        <Box boxShadow={2} p={2} borderRadius={5} bgcolor='white' overflow='hidden'>
        <Box mb={2}>
        <Typography variant='h5' fontWeight={700} color='orange'>Best Choices</Typography>
        <Typography variant='h4' fontWeight={700} color='#1f3e72'>Popular Residencies</Typography>
        {/* <ul>
        {listings.map((listing, index) => (
          <li key={index}>
            Price: {listing.price} | Listed: {listing.isListed.toString()} | Buyer: {listing.buyer} | Inspection Passed: {listing.inspectionPassed.toString()}
          </li>
        ))}
      </ul> */}
        </Box>
        <Swiper style={{overflow: 'visible', position: 'relative'}} {...sliderSettings}>
        <SliderButton />
            {
                data.map((card, i) => (
                    <SwiperSlide key={i}>
                        <CardContainer gap={0.6} display='flex' flexDirection='column' p={2} maxWidth='max-content' margin='auto' trans>
                        <ImageContainer src={card.image} alt='home'/>
                        <Box display='flex' gap={1}>
                        <Typography color='orange' fontWeight={600} fontSize='1.2rem'>$</Typography>
                        <Typography color='rgb(140, 139, 139)' fontWeight={600} fontSize='1.2rem'>{card.price}</Typography>
                        </Box>
                        <NameText fontWeight={700} color='#1f3e72'>{card.name}</NameText>
                        <Details fontWeight={700} color='rgb(140, 139, 139)'>{card.detail}</Details>
                        </CardContainer>
                    </SwiperSlide>
                ))
            }
        </Swiper>
        </Box>
    </Box>
    </div>
  )
}

export default Properties

const SliderButton = () => {
    const swiper = useSwiper()
    return (
        <Box zIndex={999} display='flex' justifyContent='center' position='absolute' gap='1rem' top='-3rem' right='0rem'>
            <CustomButton onClick={() => swiper.slidePrev()}>&lt;</CustomButton>
            <CustomButton onClick={() => swiper.slideNext()}>&gt;</CustomButton>
        </Box>
    )
}