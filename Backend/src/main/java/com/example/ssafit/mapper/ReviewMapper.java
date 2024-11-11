package com.example.ssafit.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.example.ssafit.model.Review;

@Mapper
public interface ReviewMapper {
    List<Review> getReviewsByVideoId(int videoId);
    void addReview(Review review);
    void updateReview(Review review);
    void deleteReview(int reviewId);
}
