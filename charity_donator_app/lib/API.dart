import 'dart:async';
import 'package:http/http.dart' as http;

const baseUrl = "http://192.168.100.14:8080/api";
const login = "/login";
const register = "/register";
const projects = "/projects";
const projectimages = "/projectimages/project/";
const donators = "/donators";

const header = {'Content-Type': 'application/json; charset=UTF-8',};
getHeaderJWT(token) {
  return {'Content-Type': 'application/json','Accept': 'application/json','Authorization': 'Bearer $token',};
}

class API {
  static Future getProjects() {
    var url = baseUrl + projects;
    return http.get(url);
  }
  static Future getProjectsWhenLogged(int donatorid) {
    var url = baseUrl + projects + "/donator/"+donatorid.toString();
    return http.get(url);
  }


  static Future getImageByProjectID(int id) {
    var url = baseUrl + projectimages + id.toString();
    return http.get(url);
  }


  static Future postAddProjectToFavorite(int projectid,int donatorid,String token) {
    var url = baseUrl + donators + "/addfavorite/project/"+projectid.toString()+"/donator/"+donatorid.toString();
    return http.post(url,headers:getHeaderJWT(token));
  }
  static Future postRemoveProjectFromFavorite(int projectid,int donatorid,String token) {
    var url = baseUrl + donators + "/removefavorite/project/"+projectid.toString()+"/donator/"+donatorid.toString();
    return http.post(url,headers:getHeaderJWT(token));
  }

  static Future getDonatorDetailsByPhone(String phone,String token) async{
    var url = baseUrl + donators +"/phone/"+phone;
    return await http.get(url,headers:getHeaderJWT(token));
  }
}