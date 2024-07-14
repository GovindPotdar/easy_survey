import React from 'react'
import useSurvey from './hooks/useSurvey';
import Loader from '../../components/loader';
import ListGroup from 'react-bootstrap/ListGroup';
import Container from 'react-bootstrap/Container';
import { Link } from 'react-router-dom';

function Home() {
  const {loading, surveys} = useSurvey();

  if(loading) {
    return <Loader/>
  }

  return (
    <Container className='mt-3'>
      <ListGroup as="ol" numbered>
        {surveys.map((survey) => {
          return(
            <ListGroup.Item as="li" className="d-flex justify-content-between" key={survey.id}>        
              {survey.name} 
              <Link  to={`design-survey/${survey.id}`} className="btn btn-sm btn-primary">Design</Link>
            </ListGroup.Item>
          )
        })}
      </ListGroup>
    </Container>
  );
}

export default Home;