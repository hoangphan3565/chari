import axios from "axios";
import Cookies from 'js-cookie';

const url = {
    baseUrl: "http://192.168.137.1:8080/api",
    projectTypes: "/project_types",
    students: "/students",
    donators: "/donators",
    supportedpeoples: "/supported_peoples",
    login: "/login"
};

const instance = axios.create({
    baseURL: url.baseUrl,
    headers: {"Content-Type":"application/json","Accept": "application/json"},
});

// instance.interceptors.request.use(request=>{
//     const loginInfoStr = Cookies.get("loginInfo");
//     if(loginInfoStr){
//         const loginInfo = JSON.parse(loginInfoStr);
//         request.headers.Authorization = `Bearer ${loginInfo.accessToken}`
//     }
//     return request;
// });

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