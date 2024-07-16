import React from 'react'
import useSurvey from './hooks/useSurvey'
import PropTypes from 'prop-types'

function FieldElement({ id: componentId, field, text, x_axis, y_axis, selectedComponentId, updateComponent, dispatch}) {

  const { dblClickHandler, blurHandler, mouseDownHandler, clickHandler, labelTextChangeHandler} = useSurvey();

  const style = {
    position: 'absolute',
    cursor: 'move',
    left: `${x_axis}px`,
    top: `${y_axis}px`,
  }

  if (field === 'label') {
    return (
      <div
        style={style} 
        className={`text-primary ${componentId === selectedComponentId ? 'border-danger' : 'border-primary'} form-control w-25 border`}
        onDoubleClick={(e) => dblClickHandler(e, text)} 
        onBlur={blurHandler} 
        onMouseDown={(e) => mouseDownHandler(e, componentId, updateComponent)} 
        onClick={()=>clickHandler(componentId, dispatch)}
        onInput={(e)=>labelTextChangeHandler(e, componentId, updateComponent)}  
      >
          {text || 'Double click to Edit Label'}
      </div>
    )
  }

  return (
    <div 
      style={style} 
      className={`text-info ${componentId === selectedComponentId ? 'border-danger' : 'border-info'} form-control w-25 border`} 
      onMouseDown={(e) => mouseDownHandler(e, componentId, updateComponent)} 
      onClick={()=>clickHandler(componentId, dispatch)}>
        This is a input text
    </div>
  )
}

FieldElement.propTypes = {
  id: PropTypes.number.isRequired,
  field: PropTypes.string.isRequired,
  text: PropTypes.string,
  x_axis: PropTypes.number.isRequired,
  y_axis: PropTypes.number.isRequired,
  selectedComponentId: PropTypes.number,
  updateComponent: PropTypes.func.isRequired,
  dispatch: PropTypes.func.isRequired,
}

export default FieldElement;