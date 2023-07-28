package ru.yandex.practicum.filmorate.storage.dao.review.impl;

import lombok.RequiredArgsConstructor;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Component;
import ru.yandex.practicum.filmorate.storage.dao.review.ReviewDislikeDao;

@Component
@RequiredArgsConstructor
public class ReviewDislikeDaoImpl implements ReviewDislikeDao {
    private final JdbcTemplate jdbcTemplate;

    @Override
    public void add(Long id, Long userId) {
        String sqlQuery = "INSERT INTO review_dislikes (review_id, user_id) VALUES (?,?)";
        jdbcTemplate.update(sqlQuery, id, userId);
        sqlQuery = "UPDATE reviews SET useful = useful - 1 WHERE review_id = ?";
        jdbcTemplate.update(sqlQuery, id);
    }

    @Override
    public void delete(Long id, Long userId) {
        String sqlQuery = "DELETE FROM review_dislikes WHERE review_id = ? AND user_id = ?";
        jdbcTemplate.update(sqlQuery, id, userId);
        sqlQuery = "UPDATE reviews SET useful = useful + 1 WHERE review_id = ?";
        jdbcTemplate.update(sqlQuery, id);
    }
}
