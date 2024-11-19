package com.example.ssafit.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.example.ssafit.mapper.VideoMapper;
import com.example.ssafit.model.Video;

@Service
public class VideoService {

    @Autowired
    private VideoMapper videoMapper;
    
    @Transactional
    public List<Video> getAllVideo() {
    	return videoMapper.getAllVideo();
    }

    @Transactional
	public Video addViews(Video video) {
		videoMapper.addViews(video);
		return videoMapper.getVideo(video);
	}
    
}
