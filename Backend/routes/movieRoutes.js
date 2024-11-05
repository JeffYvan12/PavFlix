// routes/movieRoutes.js
const express = require('express');
const router = express.Router();
const { addMovie, getMovies, getMovie } = require('../controllers/movieController');

router.post('/', addMovie);
router.get('/', getMovies);
router.get('/:id', getMovie);

module.exports = router;
