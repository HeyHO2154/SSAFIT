package com.example.ssafit.model;

import java.security.Timestamp;

public class User {
	private String userId;
	private String userPw;
	private String nickname;
	private String crews;
	private Timestamp login_first;
	private Timestamp login_recent;
	public String getUserId() {
		return userId;
	}
	public void setUserId(String userId) {
		this.userId = userId;
	}
	public String getUserPw() {
		return userPw;
	}
	public void setUserPw(String userPw) {
		this.userPw = userPw;
	}
	public String getNickname() {
		return nickname;
	}
	public void setNickname(String nickname) {
		this.nickname = nickname;
	}
	public String getCrews() {
		return crews;
	}
	public void setCrews(String crews) {
		this.crews = crews;
	}
	public Timestamp getLogin_first() {
		return login_first;
	}
	public void setLogin_first(Timestamp login_first) {
		this.login_first = login_first;
	}
	public Timestamp getLogin_recent() {
		return login_recent;
	}
	public void setLogin_recent(Timestamp login_recent) {
		this.login_recent = login_recent;
	}
	
	
}
