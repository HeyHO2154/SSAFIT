package com.example.ssafit.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.example.ssafit.model.Video;
import com.example.ssafit.service.VideoService;

@RestController
@RequestMapping("/api/videos")
public class VideoController {

    @Autowired
    private VideoService videoService;

    @GetMapping("/popular")
    public ResponseEntity<List<Video>> getPopularVideos() {
        return ResponseEntity.ok(videoService.getPopularVideos());
    }
    
    @PostMapping("view_up")
    public ResponseEntity<String> ViewUp(@RequestBody Video video){
    	videoService.ViewUp(video);
    	return ResponseEntity.ok("Video liked");
    }

    @GetMapping("/category/{category}")
    public ResponseEntity<List<Video>> getVideosByCategory(@PathVariable("category") String category) {
        return ResponseEntity.ok(videoService.getVideosByCategory(category));
    }

    @PostMapping("/like")
    public ResponseEntity<String> likeVideo(@RequestBody Video likeRequest) {
        videoService.likeVideo(likeRequest);
        return ResponseEntity.ok("Video liked");
    }

    @DeleteMapping("/like")
    public ResponseEntity<String> unlikeVideo(@RequestBody Video likeRequest) {
        videoService.unlikeVideo(likeRequest);
        return ResponseEntity.ok("Video unliked");
    }
}
