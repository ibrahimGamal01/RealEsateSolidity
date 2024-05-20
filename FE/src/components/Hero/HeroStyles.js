import { Box, Typography } from '@mui/material';
import { styled } from '@mui/system'

export const HeroContainer = styled(Box)({
    display: 'flex',
    flexWrap: 'nowrap',
    alignItems: 'center',
    justifyContent: 'center',
    height: '100vh',
    padding: '0 2rem',
    background: '#131110',
      boxShadow: '0 4px 30px rgba(0, 0, 0, 0.5)',
    color: '#fff',
    zIndex:-2
  })
  
  
  export const TextContainer = styled(Box)({
    flex: 1,
    padding: '2rem',
    position: 'relative',
    zIndex: 10
  })
  
  export const ListingsSoldContainer = styled(Box)({
    display: 'flex',
    justifyContent: 'space-around',
    marginTop: '2rem',
    padding: '1rem 0',
    backgroundColor: 'rgba(255, 255, 255, 0.1)',
    borderRadius: '8px',
  });
  
  export const StatBox = styled(Box)({
    textAlign: 'center',
  });
  
  export const StatNumber = styled(Typography)({
    fontSize: '2rem',
    fontWeight: 'bold',
    color: '#fff',
  });
  
  export const StatLabel = styled(Typography)({
    fontSize: '1rem',
    color: '#ccc',
  });
  
  export const GradientCircle = styled(Box)({
    position: 'absolute',
    top: '1rem',
    right: '9.5rem',
    width: '100px',
    height: '100px',
    background: 'linear-gradient(270deg, #ffb978 0%, #ff922d 100%)',
    borderRadius: '50%',
    boxShadow: '0 4px 15px rgba(0, 0, 0, 0.7)',
    zIndex: -1
  })
  
  export const WhiteGradient = styled(Box)({
    position: 'absolute',
    top: '-15rem',
    left: '5.5rem',
    width: '20rem',
    height: '20rem',
    background: 'rgba(255,255,255,0.557)',
    borderRadius: '100px',
    filter: 'blur(100px)',
    zIndex: -1
  })
  
  export const ImageContainer = styled(Box)({
    flex: 1,
    display: 'flex',
    justifyContent: 'center',
  })
  
  export const HeroImage = styled('img')({
    width: '100%',
    height: 'auto',
    borderRadius: '8px',
  })
  