package com.example.ssafit.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.example.ssafit.model.User;
import com.example.ssafit.service.UserService;

@CrossOrigin(origins = "http://70.12.50.104:3000") 
@RestController
@RequestMapping("/users")
public class UserController {

    @Autowired
    private UserService userService;

    @PostMapping("/register")
    public ResponseEntity<Boolean> register(@RequestBody User user) {
        return ResponseEntity.ok(userService.register(user));
    }

    @PostMapping("/login")
    public ResponseEntity<User> login(@RequestBody User loginRequest) {
        User user = userService.login(loginRequest);
        return ResponseEntity.ok(user);
    }
    
    @PostMapping("/getFollowersNum")
    public ResponseEntity<Integer> getFollowersNum(@RequestBody User user){
    	int FollowersNum = userService.getFollowersNum(user.getUserId());
    	return ResponseEntity.ok(FollowersNum);
    }
    
    @PostMapping("/getCrew")
    public ResponseEntity<String> getCrew(@RequestBody User user){
    	String Crewname = userService.getCrew(user.getUserId());
    	return ResponseEntity.ok(Crewname);
    }

}
