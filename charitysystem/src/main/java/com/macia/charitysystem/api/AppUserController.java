package com.macia.charitysystem.api;

import com.macia.charitysystem.DTO.AppUserDTO;
import com.macia.charitysystem.DTO.ChangePassDTO;
import com.macia.charitysystem.model.AppUser;
import com.macia.charitysystem.model.Collaborator;
import com.macia.charitysystem.model.Donator;
import com.macia.charitysystem.repository.AppUserRepository;
import com.macia.charitysystem.service.CollaboratorService;
import com.macia.charitysystem.service.DonatorService;
import com.macia.charitysystem.utility.UserType;
import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;


@RestController
@CrossOrigin("*")
@RequestMapping("/api")
public class AppUserController {


    @Autowired
    private AppUserRepository appUserRepository;

    @Autowired
    private CollaboratorService collaboratorService;

    @Autowired
    private DonatorService donatorService;

    @RequestMapping(value = "/login", method = RequestMethod.POST)
    public ResponseEntity<?> login(@RequestBody AppUser user) throws Exception {
        AppUser appuser = appUserRepository.findByUsername(user.getUsername());
        if (appuser == null || !appuser.getPassword().equals(user.getPassword())) {
            JSONObject jo = new JSONObject();
            jo.put("error code", "1");
            jo.put("data", "");
            jo.put("messenger", "Sai tên đăng nhập hoặc mật khẩu");
            return new ResponseEntity<>(jo.toMap(), HttpStatus.ALREADY_REPORTED);
        }
        JSONObject jo = new JSONObject();
        jo.put("error code", "0");
        jo.put("data", appuser);
        jo.put("messenger", "Đăng nhập thành công");
        return new ResponseEntity<>(jo.toMap(), HttpStatus.OK);
    }

    @RequestMapping(value = "/register", method = RequestMethod.POST)
    @ResponseBody
    public ResponseEntity<?> saveUser(@RequestBody AppUserDTO user) throws Exception {
        JSONObject jo = new JSONObject();
        AppUser appuser = appUserRepository.findByUsername(user.getUsername());
        if (appuser != null) {
            jo.put("error code", "1");
            jo.put("messenger", "Tên đăng nhập đã tồn tại!");
            jo.put("data", "");
            return new ResponseEntity<>(jo.toMap(), HttpStatus.ALREADY_REPORTED);
        }
        if (!user.getPassword1().equals(user.getPassword2())) {
            jo.put("error code", "1");
            jo.put("messenger", "Mật khẩu không trùng khớp!");
            jo.put("data", "");
            return new ResponseEntity<>(jo.toMap(), HttpStatus.BAD_REQUEST);
        }

        final AppUser newuser = new AppUser();
        newuser.setUsername(user.getUsername());
        newuser.setPassword(user.getPassword1());

        if (user.getUsertype().equals(UserType.Donator.toString())) {
            newuser.setUsertype(UserType.Donator);
            donatorService.save(Donator.builder().phoneNumber(user.getUsername()).favoriteProject("").build());
        } else if (user.getUsertype().equals(UserType.Collaborator.toString())) {
            newuser.setUsertype(UserType.Collaborator);
            collaboratorService.save(Collaborator.builder().phoneNumber(user.getUsername()).build());
        } else {
            jo.put("error code", "1");
            jo.put("data", "");
            jo.put("messenger", "Đăng ký thât bại!");
            return new ResponseEntity<>(jo.toMap(), HttpStatus.BAD_REQUEST);
        }
        appUserRepository.save(newuser);
        jo.put("error code", "0");
        jo.put("data", appuser);
        jo.put("messenger", "Đăng ký thành công!");
        return ResponseEntity.ok(jo.toMap());
    }

    @PostMapping("/change/password")
    public ResponseEntity<?> addProjectToFavoriteList(@RequestBody ChangePassDTO user) {
        JSONObject jo = new JSONObject();
        if(user.getUser_type().equals(UserType.Donator.toString())){
            AppUser appUser = appUserRepository.findByUsername(user.getUsername());
            if(appUser!=null){
                if(user.getCur_password().equals(appUser.getPassword())){
                    if(user.getPassword1().equals(user.getPassword2())){
                        if(!appUser.getPassword().equals(user.getPassword1()))
                        {
                            appUser.setPassword(user.getPassword1());
                            appUserRepository.saveAndFlush(appUser);
                            jo.put("error code", "0");
                            jo.put("data", appUser);
                            jo.put("messenger", "Đổi mật khẩu thành công!");
                            return new ResponseEntity<>(jo.toMap(), HttpStatus.OK);
                        }
                        else{
                            jo.put("error code", "1");
                            jo.put("data", "");
                            jo.put("messenger", "Mật khẩu mới phải khác mật khẩu cũ!");
                            return new ResponseEntity<>(jo.toMap(), HttpStatus.BAD_REQUEST);
                        }
                    }
                    else{
                        jo.put("error code", "1");
                        jo.put("data", "");
                        jo.put("messenger", "Mật khẩu mới không trùng khớp!");
                        return new ResponseEntity<>(jo.toMap(), HttpStatus.BAD_REQUEST);
                    }
                }
                else{
                    jo.put("error code", "1");
                    jo.put("data", "");
                    jo.put("messenger", "Mật khẩu hiện tại không chính xác!");
                    return new ResponseEntity<>(jo.toMap(), HttpStatus.BAD_REQUEST);
                }
            }
            jo.put("error code", "1");
            jo.put("data", "");
            jo.put("messenger", "Can't find user with username: "+user.getUsername()+ " !");
            return new ResponseEntity<>(jo.toMap(), HttpStatus.BAD_REQUEST);
        }
        else if(user.getUser_type().equals(UserType.Collaborator.toString())) {
            jo.put("error code", "1");
            jo.put("data", "");
            jo.put("messenger", "Change password for "+UserType.Collaborator.toString()+" not available!");
            return new ResponseEntity<>(jo.toMap(), HttpStatus.BAD_REQUEST);
        }
        else{
            jo.put("error code", "1");
            jo.put("data", "");
            jo.put("messenger", "Can't find user type: "+user.getUser_type());
            return new ResponseEntity<>(jo.toMap(), HttpStatus.BAD_REQUEST);
        }
    }
}