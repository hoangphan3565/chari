import 'dart:async';

import 'package:http/http.dart' as http;

const baseUrl = "http://192.168.137.1:8080/api";
//const baseUrl = "http://192.168.43.139:8080/api";

const login = "/login";
const register = "/register";
const projects = "/projects";
const projectimages = "/project_images/project/";
const donators = "/donators";
const donatedetails = "/donate_details";
const projecttypes = "/project_types";

const header = {'Content-Type': 'application/json; charset=UTF-8',};


class API {
  static Future getProjects() {
    var url = baseUrl + projects;
    return http.get(url);
  }
  static Future getProjectTypes() {
    var url = baseUrl + projecttypes;
    return http.get(url);
  }
  static Future getDonateDetailsListByDonatorId(int donator_id) {
    var url = baseUrl + donatedetails+'/donator_id/'+donator_id.toString();
    return http.get(url);
  }

  static Future getImageByProjectID(int id) {
    var url = baseUrl + projectimages + id.toString();
    return http.get(url);
  }

  static Future postAddProjectToFavorite(int projectid,int donatorid) {
    var url = baseUrl + donators + "/add_favorite/project/"+projectid.toString()+"/donator_id/"+donatorid.toString();
    return http.post(url,headers:header);
  }

  static Future postRemoveProjectFromFavorite(int projectid,int donatorid) {
    var url = baseUrl + donators + "/remove_favorite/project/"+projectid.toString()+"/donator_id/"+donatorid.toString();
    return http.post(url,headers:header);
  }
}