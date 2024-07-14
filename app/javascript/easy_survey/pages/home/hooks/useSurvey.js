import { useEffect, useState } from "react";
import useAxios from "../../../hooks/useAxios";
import { useAlert } from "react-alert";

function useSurvey() {
  const [dispatchRequest] = useAxios();
  const alert = useAlert();
  const [surveys, setSurveys] = useState([]);
  const [loading, setLoading] = useState(true);

  const fetchSurveys = () => {
    dispatchRequest('api/v1/surveys', 'GET')
      .then((res) => {
        if (res.data.status === 'success') {
          setSurveys(res.data.result);
          setLoading(false);
        } else {
          alert.error(res.data.errors.join(", "))
        }
      })
      .catch((err) => {
        alert.error("Something went wrong!")
      })
  };

  useEffect(()=>{
    fetchSurveys();
  }, []);

  return {loading, surveys};
}

export default useSurvey;