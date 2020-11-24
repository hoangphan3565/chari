package com.macia.charitysystem.api;

import com.macia.charitysystem.DTO.JwtUserDTO;
import com.macia.charitysystem.model.Collaborator;
import com.macia.charitysystem.model.Donator;
import com.macia.charitysystem.model.JwtUser;
import com.macia.charitysystem.repository.JwtUserRepository;
import com.macia.charitysystem.security.JwtRequest;
import com.macia.charitysystem.security.JwtResponse;
import com.macia.charitysystem.security.JwtTokenUtil;
import com.macia.charitysystem.security.JwtUserDetailsService;
import com.macia.charitysystem.service.CollaboratorService;
import com.macia.charitysystem.service.DonatorService;
import com.macia.charitysystem.utility.UserType;
import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.authentication.BadCredentialsException;
import org.springframework.security.authentication.DisabledException;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.web.bind.annotation.*;



@RestController
@CrossOrigin("*")
@RequestMapping("/api")
public class JwtAuthenticationController {

	@Autowired
	private AuthenticationManager authenticationManager;

	@Autowired
	private JwtTokenUtil jwtTokenUtil;

	@Autowired
	private JwtUserDetailsService userDetailsService;

	@Autowired
	private JwtUserRepository jwtuserRepo;

	@Autowired
	private CollaboratorService collaboratorService;

	@Autowired
	private DonatorService donatorService;

	@RequestMapping(value = "/login", method = RequestMethod.POST)
	public ResponseEntity<?> createAuthenticationToken(@RequestBody JwtRequest authenticationRequest) throws Exception {

		authenticate(authenticationRequest.getUsername(), authenticationRequest.getPassword());

		final UserDetails userDetails = userDetailsService
				.loadUserByUsername(authenticationRequest.getUsername());

		final String token = jwtTokenUtil.generateToken(userDetails);

		return ResponseEntity.ok(new JwtResponse(token));
	}
	
	@RequestMapping(value = "/register", method = RequestMethod.POST)
	@ResponseBody
	public ResponseEntity<?> saveUser(@RequestBody JwtUserDTO user) throws Exception {
		BCryptPasswordEncoder passwordEncoder = new BCryptPasswordEncoder();
		if(jwtuserRepo.findByUsername(user.getUsername())!=null){
			JSONObject jo = new JSONObject();
			jo.put("messenger", "Sign up falid! Username has been taken!");
			return new ResponseEntity<>(jo.toMap(), HttpStatus.ALREADY_REPORTED);
		}
		if(!user.getPassword1().equals(user.getPassword2())){
			JSONObject jo = new JSONObject();
			jo.put("messenger", "Sign up falid! Password does not match");
			return new ResponseEntity<>(jo.toMap(),HttpStatus.BAD_REQUEST);
		}
		String p = passwordEncoder.encode(user.getPassword1());
		final JwtUser newuser = new JwtUser();
		newuser.setUsername(user.getUsername());
		newuser.setPassword(p);

		if(user.getUsertype().equals(UserType.Donator.toString()))
		{
			newuser.setUsertype(UserType.Donator);
			donatorService.save(Donator.builder().phoneNumber(user.getUsername()).favoriteProject("").build());
		}else if(user.getUsertype().equals(UserType.Collaborator.toString())){
			newuser.setUsertype(UserType.Collaborator);
			collaboratorService.save(Collaborator.builder().phoneNumber(user.getUsername()).build());
		}else{
			JSONObject jo = new JSONObject();
			jo.put("messenger", "Sign up falid!");
			return new ResponseEntity<>(jo.toMap(),HttpStatus.BAD_REQUEST);
		}
		jwtuserRepo.save(newuser);
		JSONObject jo = new JSONObject();
		jo.put("messenger", "Sign up successfully!");
		return ResponseEntity.ok(jo.toMap());
	}

	private void authenticate(String username, String password) throws Exception {
		try {
			authenticationManager.authenticate(new UsernamePasswordAuthenticationToken(username, password));
		} catch (DisabledException e) {
			throw new Exception("USER_DISABLED", e);
		} catch (BadCredentialsException e) {
			throw new Exception("INVALID_CREDENTIALS", e);
		}
	}
}