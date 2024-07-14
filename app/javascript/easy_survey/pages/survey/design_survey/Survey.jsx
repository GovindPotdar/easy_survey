import React, { useEffect, useReducer } from 'react'
import useSurvey from './hooks/useSurvey';
import Button from 'react-bootstrap/Button';
import { componentReducer, INITIAL_STATE } from './reducers/componentReducer';
import useDesignSurvey from './hooks/useDesignSurvey';
import Loader from '../../../components/loader';
import FieldElement from './FieldElement';

function Survey() {
  const [componentState, dispatch] = useReducer(componentReducer, INITIAL_STATE);
  const {createComponent, fetchComponents, updateComponent, deleteComponent} = useDesignSurvey(dispatch);
  const {onDropHandler} = useSurvey();
  
  useEffect(()=>{
    fetchComponents(dispatch);
  }, []);

  const { loading, selectedComponentId, present: { components } } = componentState;
  if(loading){
    return <Loader/>;
  }

  return (
    <div>
      <div className='m-2'>
        <Button className={`btn btn-sm ${selectedComponentId === null ? 'btn-light' : 'btn-danger'} border`} title="select any component to remove" disabled={selectedComponentId === null} onClick={()=>deleteComponent(selectedComponentId)}>Remove</Button>
      </div>
      <div id="survey-container" onDrop={(e)=>onDropHandler(e, createComponent)} onDragOver={(e) => e.preventDefault()} style={{ height: "900px", width: "1273px", position: "relative" }} className='border-1 border bg-light'>
        {
          components.map((component) => {
            const { id } = component;
            return <FieldElement {...component} key={id} updateComponent={updateComponent} selectedComponentId={selectedComponentId} dispatch={dispatch}/>
          })
        }
      </div>
    </div>
  )
}

export default Survey;