import React from 'react'
import { BrowserRouter } from 'react-router-dom';
import AppRoutes from "./app_routes";
import AlertContainer from './components/alert_container';

function App() {
  return (
    <AlertContainer>
      <BrowserRouter>
        <AppRoutes/>
      </BrowserRouter>
    </AlertContainer>
  )
}

export default App;