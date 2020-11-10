const baseUrl = "http://192.168.100.19:8080/api";
const login = "/login";
const register = "/register";
const projects = "/projects";

const header = {'Content-Type': 'application/json; charset=UTF-8',};
getHeaderJWT(token) {
  return {'Content-Type': 'application/json','Accept': 'application/json','Authorization': 'Bearer $token',};
}
