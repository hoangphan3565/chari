import 'dart:async';
import 'package:http/http.dart' as http;

const baseUrl = "http://192.168.100.25:8080/api";
const login = "/login";
const register = "/register";
const projects = "/projects";

const header = {'Content-Type': 'application/json; charset=UTF-8',};
getHeaderJWT(token) {
  return {'Content-Type': 'application/json','Accept': 'application/json','Authorization': 'Bearer $token',};
}

class API {
  static Future getProjects() {
    var url = baseUrl + projects;
    return http.get(url);
  }
  static Future getProjectDetails(int id) {
    var url = baseUrl + projects+"/"+id.toString();
    return http.get(url);
  }
}