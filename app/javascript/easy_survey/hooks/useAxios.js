import axios from "axios";

function useAxios() {

  const prepareUrl = (path) => {
    return `http://localhost:3000/${path}`
  }

  const dispatchRequest = async (path, method, data) => {
    return await axios({
      url: prepareUrl(path),
      type: "json",
      method,
      headers: {
        API_KEY: '123456',
      },
      data,
    })
  }

  return [dispatchRequest];
}

export default useAxios;