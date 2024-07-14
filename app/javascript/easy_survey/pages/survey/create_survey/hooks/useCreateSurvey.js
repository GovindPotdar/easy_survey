import useAxios from "../../../../hooks/useAxios";
import { useAlert } from "react-alert";
import { useNavigate } from "react-router-dom";

function useCreateSurvey() {
  const [dispatchRequest] = useAxios();
  const alert = useAlert();
  const navigate = useNavigate();

  const onSubmit = (data) => {
    dispatchRequest('api/v1/surveys', 'POST', data)
      .then((res) => {
        if (res.data.status === 'success') {
          alert.success("Survey created!");
          navigate(`/design-survey/${res.data.result.id}`)
        } else {
          alert.error(res.data.errors.join(", "))
        }
      })
      .catch((err) => {
        alert.error("Something went wrong!")
      })
  }
  return [onSubmit];
}

export default useCreateSurvey;