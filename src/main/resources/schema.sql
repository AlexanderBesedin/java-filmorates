-- Для тестов
DROP TABLE IF EXISTS users, friendship, mpa, films, genres, film_genres, film_likes, directors, film_directors, events,
reviews, review_likes, review_dislikes;

-- Таблица с пользователями
CREATE TABLE IF NOT EXISTS users (
    id       LONG GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
    email    VARCHAR      NOT NULL UNIQUE,
    login    VARCHAR      NOT NULL UNIQUE,
    name     VARCHAR      NOT NULL,
    birthday DATE         NOT NULL,
    CONSTRAINT user_const CHECK (login <> '' AND email <> '')
);

-- Таблица со статусами дружбы
CREATE TABLE IF NOT EXISTS friendship (
    user_id        LONG NOT NULL REFERENCES users (id) ON DELETE CASCADE ON UPDATE CASCADE,
    friend_user_id LONG NOT NULL REFERENCES users (id) ON DELETE CASCADE ON UPDATE CASCADE,
    PRIMARY KEY (user_id, friend_user_id)
);

-- Таблица с рейтингами фильмов
CREATE TABLE IF NOT EXISTS mpa (
    mpa_id INTEGER GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
    name   VARCHAR NOT NULL
);

-- Таблица с фильмами
CREATE TABLE IF NOT EXISTS films (
    id          LONG GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
    name        VARCHAR      NOT NULL CHECK (name <> ''),
    description VARCHAR(200) NOT NULL,
    duration    INTEGER CHECK (duration > 0),
    releaseDate DATE,
    mpa_id      INTEGER      NOT NULL,
    FOREIGN KEY (mpa_id) REFERENCES mpa (mpa_id)
);

-- Таблица со всеми жанрами
CREATE TABLE IF NOT EXISTS genres (
    genre_id INTEGER GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
    name     VARCHAR NOT NULL
);

-- Таблица с жанрами фильмов
CREATE TABLE IF NOT EXISTS film_genres (
    film_id  LONG REFERENCES films (id) ON delete CASCADE,
    genre_id INTEGER REFERENCES genres (genre_id) ON delete CASCADE,
    PRIMARY KEY (film_id, genre_id)
);

-- Таблица с лайками пользователей
CREATE TABLE IF NOT EXISTS film_likes (
        film_id LONG REFERENCES films(id) ON delete CASCADE,
        user_id LONG REFERENCES users(id) ON delete CASCADE,
        PRIMARY KEY(film_id, user_id)
);

-- Таблица с режиссерами
CREATE TABLE IF NOT EXISTS directors (
    director_id LONG GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
    name        VARCHAR NOT NULL CHECK (name <> '')
);

-- Таблица с фильмами режиссеров
CREATE TABLE IF NOT EXISTS film_directors (
    director_id LONG REFERENCES directors (director_id) ON delete CASCADE,
    film_id LONG REFERENCES films (id) ON delete CASCADE
);

-- Таблица с отзывами пользователей
CREATE TABLE IF NOT EXISTS reviews (
    review_id   LONG GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
    content     TEXT NOT NULL CHECK (content <> ''),
    is_positive BOOLEAN,
    user_id     LONG NOT NULL REFERENCES users (id) ON delete CASCADE,
    film_id     LONG NOT NULL REFERENCES films (id) ON delete CASCADE,
    useful      INT DEFAULT 0
);

-- Таблица с положительными оценками отзывов
CREATE TABLE IF NOT EXISTS review_likes (
    review_id  LONG NOT NULL REFERENCES reviews (review_id)  ON delete CASCADE,
    user_id    LONG NOT NULL REFERENCES users (id)  ON delete CASCADE,
    PRIMARY KEY (review_id, user_id)
);

-- Таблица с негативными оценками отзывов
CREATE TABLE IF NOT EXISTS review_dislikes (
    review_id  LONG NOT NULL REFERENCES reviews (review_id)  ON delete CASCADE,
    user_id    LONG NOT NULL REFERENCES users (id)  ON delete CASCADE,
    PRIMARY KEY (review_id, user_id)
);
-- Таблица с событиями
CREATE TABLE IF NOT EXISTS events (
        timestamp TIMESTAMP,
        userId LONG REFERENCES users(id) ON delete CASCADE, -- нужно ли удалять если удалили пользователя???
        eventType VARCHAR,
        operation VARCHAR,
        eventId LONG GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
        entityId INTEGER
);