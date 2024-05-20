import { BrowserRouter as Router, Route, Routes } from 'react-router-dom'
import Home from './screens/Home';
import ListingAdd from './screens/ListingAdd';


function App() {
  return (
    <Router>
      <div>
        <Routes>
          <Route path="/" element={<Home />} />
          <Route path="/add-listing" element={<ListingAdd />} />
        </Routes>
      </div>
    </Router>
  );
}

export default App;
