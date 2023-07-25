package ru.yandex.practicum.filmorate.controller;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.web.bind.annotation.*;
import ru.yandex.practicum.filmorate.model.Director;
import ru.yandex.practicum.filmorate.service.DBDirectorService;

import javax.validation.Valid;
import java.util.List;

@RestController
@RequestMapping("/directors")
@Slf4j
@RequiredArgsConstructor
public class DirectorsController {
    private final DBDirectorService dbDirectorService;

    @PostMapping
    public Director create(@Valid @RequestBody Director director) {
        return dbDirectorService.create(director);
    }

    @PutMapping
    public Director update(@Valid @RequestBody Director director) {
        return dbDirectorService.update(director);
    }

    @GetMapping
    public List<Director> getDirectors() {
        return dbDirectorService.getDirectors();
    }

    @GetMapping("/{id}")
    public Director getDirectorById(@PathVariable("id") Integer directorId) {
        return dbDirectorService.getDirector(directorId);
    }

    @DeleteMapping("/{id}")
    public void deleteDirector(@PathVariable("id") Integer directorId) {
        dbDirectorService.deleteDirector(directorId);
    }
}