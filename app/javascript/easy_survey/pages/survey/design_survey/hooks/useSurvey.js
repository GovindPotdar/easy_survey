function useSurvey() {

  const dblClickHandler = (e, text) => {
    let element = e.target;
    element.contentEditable = true;
    element.innerText = text;
    element.style.cursor = "auto";
    element.focus();
  };

  const blurHandler = (e) => {
    const element = e.target;
    element.contentEditable = false;
    element.style.cursor = "move";
  }

  const clickHandler = (componentId, dispatch) => {
    dispatch({
      type: 'UPDATE_SELECTED_COMPONENT',
      payload: componentId,
    });
  };

  const mouseDownHandler = (e, updateComponent, componentId) => {
    const element = e.target;
    if (element.contentEditable === "true") return;
    e.preventDefault();
    let offsetX = e.clientX - element.getBoundingClientRect().left;
    let offsetY = e.clientY - element.getBoundingClientRect().top;
    let shouldChangeComponentAxis = false;
    let newComponentX;
    let newComponentY;

    const mouseMove = (e) => {
      const newX = e.clientX - offsetX;
      const newY = e.clientY - offsetY;
      const surveyContainer = document.getElementById('survey-container');
      const containerRect = surveyContainer.getBoundingClientRect();
      const elemRect = element.getBoundingClientRect();

      shouldChangeComponentAxis = newX >= containerRect.left &&
      newX + elemRect.width <= containerRect.right &&
      newY >= containerRect.top &&
      newY + elemRect.height <= containerRect.bottom;
      newComponentX = newX - containerRect.left;
      newComponentY = newY - containerRect.top;
      if (shouldChangeComponentAxis) {
        element.style.left = `${newComponentX}px`;
        element.style.top = `${newComponentY}px`;
      }
    };

    const mouseUp = (e) => {
      if(shouldChangeComponentAxis) {
        updateComponent({
          component: {
            x_axis: newComponentX,
            y_axis: newComponentY,
          }
        }, componentId);
      }
      element.removeEventListener('mousemove', mouseMove);
      element.removeEventListener('mouseup', mouseUp);
    };
    element.addEventListener('mousemove', mouseMove);
    element.addEventListener('mouseup', mouseUp);
  };

  const onDropHandler = (e, createComponent) => {
    e.preventDefault();
    const field = e.dataTransfer.getData('text/plain');
    if (field !== 'label' && field !== 'input_text') return
    const surveyContainer = e.target;
    createComponent({
      component: {
        field,
        text: "",
        x_axis: e.clientX - surveyContainer.offsetLeft,
        y_axis: e.clientY - surveyContainer.offsetTop
      }
    });
  };

  const labelTextChangeHandler = (e, updateComponent, componentId) => {
    const text = e.target.innerText;
    updateComponent({
      component: {
        text
      }
    }, componentId);
  };

  return {dblClickHandler, blurHandler, mouseDownHandler, clickHandler, onDropHandler, labelTextChangeHandler};
}

export default useSurvey;