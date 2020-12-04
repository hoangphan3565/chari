import 'dart:async';

import 'package:http/http.dart' as http;

const baseUrl = "http://192.168.100.15:8080/api";
//const baseUrl = "http://192.168.43.139:8080/api";

const login = "/login";
const register = "/register";
const projects = "/projects";
const projectimages = "/projectimages/project/";
const donators = "/donators";

const header = {'Content-Type': 'application/json; charset=UTF-8',};


class API {
  static Future getProjects() {
    var url = baseUrl + projects;
    return http.get(url);
  }

  static Future getImageByProjectID(int id) {
    var url = baseUrl + projectimages + id.toString();
    return http.get(url);
  }

  static Future postAddProjectToFavorite(int projectid,int donatorid) {
    var url = baseUrl + donators + "/addfavorite/project/"+projectid.toString()+"/donator/"+donatorid.toString();
    return http.post(url,headers:header);
  }
  static Future postRemoveProjectFromFavorite(int projectid,int donatorid) {
    var url = baseUrl + donators + "/removefavorite/project/"+projectid.toString()+"/donator/"+donatorid.toString();
    return http.post(url,headers:header);
  }
}