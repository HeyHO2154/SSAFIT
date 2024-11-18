package com.example.ssafit.model;

public class Comments {
	private String userId;
	private String videoId;
	private String contexts;
	private int likes;
	public String getUserId() {
		return userId;
	}
	public void setUserId(String userId) {
		this.userId = userId;
	}
	public String getVideoId() {
		return videoId;
	}
	public void setVideoId(String videoId) {
		this.videoId = videoId;
	}
	public String getContexts() {
		return contexts;
	}
	public void setContexts(String contexts) {
		this.contexts = contexts;
	}
	public int getLikes() {
		return likes;
	}
	public void setLikes(int likes) {
		this.likes = likes;
	}
	
}
