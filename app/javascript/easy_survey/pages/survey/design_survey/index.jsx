import React from 'react'
import ToolBox from './ToolBox';
import Survey from './Survey';
import Row from 'react-bootstrap/Row';
import Col from 'react-bootstrap/Col';

function DesignSurvey() {
  return (
    <Row className='m-2'>
      <Col sm={3}>
        <ToolBox/>
      </Col>
      <Col sm={9}>
        <Survey/>
      </Col>
    </Row>
  )
}

export default DesignSurvey;