import { Box, Button, Typography } from "@mui/material";
import { styled } from "styled-components";

export const CardContainer = styled(Box)`
transition: all 300ms ease-in;
border-radius: 25px;
overflow: visible;
&:hover {
    cursor: pointer;
    scale: 1.025;
    background: linear-gradient(180deg, rgba(255, 255, 255, 0) 0%, rgba(136, 160, 255, 0.46) 100%);
    box-shadow: 0 72px 49px -51px #88a0ff36;
  }
`

export const ImageContainer = styled.img`
width: 100%;
max-width: 15rem;
`

export const NameText = styled(Typography)`
font-size: 1.5rem;
`

export const Details = styled(Typography)`
font-size: 0.7rem;
width: 100%;
max-width: 15rem;
`

export const CustomButton = styled.button`
font-size: 1rem;
padding: 0.2rem;
color: blue;
border: none;
border-radius: 5px;
background: #fff;
width: 30px !important;
height: 30px;
`