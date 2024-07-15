import { useParams } from "react-router-dom";
import useAxios from "../../../../hooks/useAxios";
import { useAlert } from "react-alert";
import { useNavigate } from "react-router-dom";

function useDesignSurvey(dispatch) {
    const [dispatchRequest] = useAxios();
    const { surveyId } = useParams();
    const alert = useAlert();
    const navigate = useNavigate();

    const fetchComponents = (data) => {
      dispatch({
          type: 'UPDATE_LOADING',
          payload: true,
      });
      dispatchRequest(`api/v1/surveys/${surveyId}/components`, 'GET')
        .then((res) => {
          if (res.data.status === 'success') {
            dispatch({
                type: 'SET_COMPONENTS',
                payload: res.data.result
            });
          } else {
            alert.error(res.data.errors.join(", "));
            navigate('/');
          }
          dispatch({
            type: 'UPDATE_LOADING',
            payload: false,
          });
        })
        .catch((err) => {
          alert.error("Something went wrong!");
          navigate('/');
        })
    }

    const createComponent  = (data)=>{
      dispatchRequest(`api/v1/surveys/${surveyId}/components`, 'POST', data)
      .then((res) => {
        if (res.data.status === 'success') {
          dispatch({
              type: 'ADD_COMPONENT',
              payload: res.data.result
          });
        } else {
          alert.error(res.data.errors.join(", "))
        }
      })
      .catch((err) => {
        alert.error("Something went wrong!")
      })
    }

    const updateComponent  = (data, componentId)=>{
      dispatchRequest(`api/v1/surveys/${surveyId}/components/${componentId}`, 'PATCH', data)
      .then((res) => {
        if (res.data.status === 'success') {
          dispatch({
              type: 'UPDATE_COMPONENT',
              payload: res.data.result
          });
        } else {
          alert.error(res.data.errors.join(", "))
        }
      })
      .catch((err) => {
        alert.error("Something went wrong!")
      })
    }

    const deleteComponent = (componentId) => {
      if(componentId === null) return;
      dispatchRequest(`api/v1/surveys/${surveyId}/components/${componentId}`, 'DELETE')
      .then((res) => {
        if (res.data.status === 'success') {
          dispatch({
              type: 'DELETE_COMPONENT',
              payload: componentId
          });
          dispatch({
            type: 'UPDATE_SELECTED_COMPONENT',
            payload: null
          });
        } else {
          alert.error(res.data.errors.join(", "))
        }
      })
      .catch((err) => {
        alert.error("Something went wrong!")
      })
    };

    const handleUndoRedo = (components, operation) => {
      if(components === undefined) return
      dispatchRequest(`api/v1/surveys/${surveyId}/components/bulk_update`, 'PATCH', components)
      .then((res) => {
        if (res.data.status === 'success') {
          dispatch({ type: operation });
        } else {
          alert.error(res.data.errors.join(", "))
        }
      })
      .catch((err) => {
        alert.error("Something went wrong!")
      })
    };

    const undoSurveyDesign = (pastComponents) => {
      const components = pastComponents[pastComponents.length - 1];
      handleUndoRedo(components, 'UNDO');
    };

    const redoSurveyDesign = (futureComponents)=>{
      const components = futureComponents[0];
      handleUndoRedo(components, 'REDO');
    };

    return {createComponent, fetchComponents, updateComponent, deleteComponent, undoSurveyDesign, redoSurveyDesign};
}

export default useDesignSurvey;