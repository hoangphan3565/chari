import axios from "axios";
import Cookies from 'js-cookie';

const url = {
    baseUrl: "https://www.saigontech.edu.vn/restful-api",
    majors: "/majors",
    students: "/students",
    instructors: "/instructors",
    login: "/login"
};

const instance = axios.create({
    baseURL: url.baseUrl,
    headers: {"Content-Type":"application/json","Accept": "application/json"},
});

instance.interceptors.request.use(request=>{
    const loginInfoStr = Cookies.get("loginInfo");
    if(loginInfoStr){
        const loginInfo = JSON.parse(loginInfoStr);
        request.headers.Authorization = `Bearer ${loginInfo.accessToken}`
    }
    return request;
});

instance.interceptors.response.use(response=>{
    return response;
    },(error)=>{
        if(error.response.status === 401){
            window.location.href = "/login";
        }
    }
);

export default {
    url: url,
    axios: instance,
    get: instance.get,
    post: instance.post,
    put: instance.put,
    delete: instance.delete,
};