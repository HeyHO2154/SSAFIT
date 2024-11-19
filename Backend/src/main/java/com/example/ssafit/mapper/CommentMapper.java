package com.example.ssafit.mapper;

import java.util.List;

import javax.xml.stream.events.Comment;

import org.apache.ibatis.annotations.Mapper;

import com.example.ssafit.model.Video;

@Mapper
public interface CommentMapper {
	List<Comment> getAllComments(Video video);
}
