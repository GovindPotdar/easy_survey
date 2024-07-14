import React from 'react'
import Card from 'react-bootstrap/Card';
import Button from 'react-bootstrap/Button';

function ToolBox() {  

  const dragStartHandler = (e) => {
    e.dataTransfer.setData('text/plain', e.target.dataset.type);
  }

  return (
    <div id="toolbox" className='border-1'>
      <Card >
        <Card.Body className='d-flex flex-column'>
        <Card.Title>Tool Box</Card.Title>
          <Button onDragStart={dragStartHandler} data-type="label" variant="light" draggable="true" className='p-2 m-2 text-primary border border-primary'>Label</Button>
          <Button onDragStart={dragStartHandler} data-type="input_text" variant="light" draggable="true" className='p-2 m-2 text-info border border-info'>input text</Button>
        </Card.Body>
      </Card>
    </div>
  )
}

export default ToolBox;