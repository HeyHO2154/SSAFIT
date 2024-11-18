package com.example.ssafit.mapper;

import com.example.ssafit.model.*;
import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface UserMapper {
    void registerUser(User user);
    User login(User loginRequest);
}
