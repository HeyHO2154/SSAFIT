package com.example.ssafit.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.example.ssafit.mapper.ReviewMapper;
import com.example.ssafit.model.Review;

@Service
public class ReviewService {

    @Autowired
    private ReviewMapper reviewMapper;
    
    public List<Review> getReviewsByVideoId(int videoId) {
        return reviewMapper.getReviewsByVideoId(videoId);
    }

    public void addReview(Review review) {
        reviewMapper.addReview(review);
    }

    public void updateReview(int reviewId, Review review) {
        reviewMapper.updateReview(review);
    }

    public void deleteReview(int reviewId) {
        reviewMapper.deleteReview(reviewId);
    }
}
