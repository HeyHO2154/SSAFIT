package com.example.ssafit.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.example.ssafit.model.Video;

@Mapper
public interface VideoMapper {
    List<Video> getPopularVideos();
    List<Video> getVideosByCategory(String category);
    void likeVideo(Video video);
    void unlikeVideo(Video video);
	void UpCount(Video video);
}
