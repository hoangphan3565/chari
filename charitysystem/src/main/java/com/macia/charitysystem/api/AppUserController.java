package com.macia.charitysystem.api;

import com.macia.charitysystem.DTO.JwtUserDTO;
import com.macia.charitysystem.model.Collaborator;
import com.macia.charitysystem.model.Donator;
import com.macia.charitysystem.model.AppUser;
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
		if(appuser==null || !appuser.getPassword().equals(user.getPassword())){
			JSONObject jo = new JSONObject();
			jo.put("error code","1");
			jo.put("data","");
			jo.put("messenger", "Login fail!");
			return new ResponseEntity<>(jo.toMap(), HttpStatus.ALREADY_REPORTED);
		}
		JSONObject jo = new JSONObject();
		jo.put("error code","0");
		jo.put("messenger", "Login successfully!");
		jo.put("data",appuser);
		return new ResponseEntity<>(jo.toMap(),HttpStatus.OK);
	}
	
	@RequestMapping(value = "/register", method = RequestMethod.POST)
	@ResponseBody
	public ResponseEntity<?> saveUser(@RequestBody JwtUserDTO user) throws Exception {
		AppUser appuser = appUserRepository.findByUsername(user.getUsername());
		if(appuser!=null){
			JSONObject jo = new JSONObject();
			jo.put("error code","2");
			jo.put("messenger", "Sign up fail! Username has been taken!");
			jo.put("data","");
			return new ResponseEntity<>(jo.toMap(), HttpStatus.ALREADY_REPORTED);
		}
		if(!user.getPassword1().equals(user.getPassword2())){
			JSONObject jo = new JSONObject();
			jo.put("error code","3");
			jo.put("messenger", "Sign up fail! Password does not match");
			jo.put("data","");
			return new ResponseEntity<>(jo.toMap(),HttpStatus.BAD_REQUEST);
		}
		final AppUser newuser = new AppUser();
		newuser.setUsername(user.getUsername());
		newuser.setPassword(user.getPassword1());

		if(user.getUsertype().equals(UserType.Donator.toString()))
		{
			newuser.setUsertype(UserType.Donator);
			donatorService.save(Donator.builder().phoneNumber(user.getUsername()).favoriteProject("").build());
		}else if(user.getUsertype().equals(UserType.Collaborator.toString())){
			newuser.setUsertype(UserType.Collaborator);
			collaboratorService.save(Collaborator.builder().phoneNumber(user.getUsername()).build());
		}else{
			JSONObject jo = new JSONObject();
			jo.put("error code","1");
			jo.put("messenger", "Sign up falid!");
			jo.put("data","");
			return new ResponseEntity<>(jo.toMap(),HttpStatus.BAD_REQUEST);
		}
		appUserRepository.save(newuser);
		JSONObject jo = new JSONObject();
		jo.put("error code","0");
		jo.put("messenger", "Sign up successfully!");
		jo.put("data",appuser);
		return ResponseEntity.ok(jo.toMap());
	}
}