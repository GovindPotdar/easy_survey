import React, { useEffect, useReducer } from 'react'
import useSurvey from './hooks/useSurvey';
import Button from 'react-bootstrap/Button';
import { componentReducer, INITIAL_STATE } from './reducers/componentReducer';
import useDesignSurvey from './hooks/useDesignSurvey';
import Loader from '../../../components/loader';
import FieldElement from './FieldElement';

function Survey() {
  const [componentState, dispatch] = useReducer(componentReducer, INITIAL_STATE);
  const {fetchComponents, deleteComponent, undoSurveyDesign, redoSurveyDesign, createComponent, updateComponent} = useDesignSurvey(dispatch);
  const {onDropHandler} = useSurvey();
  
  useEffect(()=>{
    fetchComponents(dispatch);
  }, []);

  const { loading, selectedComponentId, past, future, present: { components } } = componentState;
  if(loading){
    return <Loader/>;
  }

  return (
    <div>
      <div className='m-2'>
        <Button className={`btn btn-sm ${selectedComponentId === null ? 'btn-light' : 'btn-danger'} border`} title="Select any component to remove" onClick={()=>deleteComponent(selectedComponentId)}>Remove</Button>

        <Button className='btn btn-sm btn-primary border mx-2' disabled={past.length === 0} title="UNDO" onClick={()=>undoSurveyDesign(past)}>Undo</Button>
        <Button className='btn btn-sm btn-primary border' title="REDO" disabled={future.length === 0} onClick={()=>redoSurveyDesign(future)}>Redo</Button>
      </div>
      <div id="survey-container" onDrop={(e)=>onDropHandler(e, createComponent)} onDragOver={(e) => e.preventDefault()} style={{ height: "900px", width: "1273px", position: "relative" }} className='border-1 border bg-light'>
        {
          components.map((component) => {
            const { id } = component;
            return <FieldElement {...component} key={id} selectedComponentId={selectedComponentId} dispatch={dispatch} updateComponent={updateComponent}/>
          })
        }
      </div>
    </div>
  )
}

export default Survey;