package ru.yandex.practicum.filmorate.storage.dao.film;

import ru.yandex.practicum.filmorate.model.Genre;

import java.util.List;
import java.util.Set;

public interface GenreDao {

    void add(Integer filmId, Integer genreId);

    Set<Genre> findFilmGenres(Integer filmId);

    Genre findById(Integer id);

    List<Genre> findAll();

    void deleteFilmGenres(Integer filmId);
}
