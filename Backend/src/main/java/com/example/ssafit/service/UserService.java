package com.example.ssafit.service;

import com.example.ssafit.model.User; // 올바른 User 클래스 import
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.example.ssafit.mapper.UserMapper;

@Service
public class UserService {

    @Autowired
    private UserMapper userMapper;

    public void register(User user) {
        userMapper.registerUser(user);
    }

    public User login(User loginRequest) {
        return userMapper.login(loginRequest);
    }
}
