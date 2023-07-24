package ru.yandex.practicum.filmorate.storage.dao.review.impl;

import lombok.RequiredArgsConstructor;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Component;
import ru.yandex.practicum.filmorate.storage.dao.review.ReviewLikeDao;

@Component
@RequiredArgsConstructor
public class ReviewLikeDaoImpl implements ReviewLikeDao {
    private final JdbcTemplate jdbcTemplate;

    @Override
    public void setLike(Integer id, Integer userId) {
        String sqlQuery = "INSERT INTO review_likes (review_id, user_id) VALUES (?,?)";
        jdbcTemplate.update(sqlQuery, id, userId);
    }

    @Override
    public void deleteLike(Integer id, Integer userId) {
        String sqlQuery = "DELETE FROM review_likes WHERE review_id = ? AND user_id = ?";
        jdbcTemplate.update(sqlQuery, id, userId);
    }
}