import React from 'react'
import Card from 'react-bootstrap/Card';

function PageNotFound() {
  return (
    <Card className="text-center container mt-5">
      <Card.Body>
        <Card.Title>Page Not Found</Card.Title>
        <Card.Text>
          <h1>404</h1>
        </Card.Text>
      </Card.Body>
    </Card>
  )
}

export default PageNotFound;