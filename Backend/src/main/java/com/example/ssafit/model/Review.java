package com.example.ssafit.model;

public class Review {
    private int id;
    private int videoId;
    private int userId;
    public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public int getVideoId() {
		return videoId;
	}
	public void setVideoId(int videoId) {
		this.videoId = videoId;
	}
	public int getUserId() {
		return userId;
	}
	public void setUserId(int userId) {
		this.userId = userId;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	private String content;

    // Getters and Setters
}
