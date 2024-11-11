package com.example.ssafit.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.example.ssafit.mapper.VideoMapper;
import com.example.ssafit.model.Video;

@Service
public class VideoService {

    @Autowired
    private VideoMapper videoMapper;

    public List<Video> getPopularVideos() {
        return videoMapper.getPopularVideos();
    }

    public List<Video> getVideosByCategory(String category) {
        return videoMapper.getVideosByCategory(category);
    }

    public void likeVideo(Video video) {
        videoMapper.likeVideo(video);
    }

    public void unlikeVideo(Video video) {
        videoMapper.unlikeVideo(video);
    }

	public void ViewUp(Video video) {
		videoMapper.UpCount(video);
	}
}
