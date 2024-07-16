import React, { Children } from 'react'
import { transitions, positions, Provider as AlertProvider } from 'react-alert'
import AlertTemplate from 'react-alert-template-basic'
import PropTypes from 'prop-types'

function AlertContainer({children}) {
    const options = {
    position: positions.BOTTOM_RIGHT,
    timeout: 3000,
    offset: '30px',
    transition: transitions.SCALE
  }
  
  return (
    <AlertProvider template={AlertTemplate} {...options}>
      {children}  
    </AlertProvider>
  )
}

AlertContainer.propTypes = {
  children: PropTypes.node.isRequired,
}

export default AlertContainer;