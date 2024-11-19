package com.example.ssafit.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.example.ssafit.model.Video;
import com.example.ssafit.service.VideoService;

@CrossOrigin(origins = "http://localhost:3000") // 프론트엔드 포트를 지정	
@RestController
@RequestMapping("/videos")
public class VideoController {

    @Autowired
    private VideoService videoService;

    @PostMapping("/getAllVideo")
    public ResponseEntity<List<Video>> getAllVideo() {
        List<Video> videos = videoService.getAllVideo(); // 여러 비디오를 반환한다고 가정
        return ResponseEntity.ok(videos); // ResponseEntity로 감싸서 반환
    }

}
