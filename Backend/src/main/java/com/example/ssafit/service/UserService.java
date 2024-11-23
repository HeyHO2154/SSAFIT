package com.example.ssafit.service;

import com.example.ssafit.model.User; // 올바른 User 클래스 import
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.example.ssafit.mapper.UserMapper;

@Service
public class UserService {

    @Autowired
    private UserMapper userMapper;

    public boolean register(User user) {
    	System.out.println(user);
    	if(userMapper.getUserById(user)==null) {
    		userMapper.registerUser(user);
    		return true;
    	}
    	return false;
    }

    public User login(User user) {
        return userMapper.login(user);
    }
}
