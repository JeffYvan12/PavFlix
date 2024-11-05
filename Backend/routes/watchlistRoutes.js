// routes/watchlistRoutes.js
const express = require('express');
const router = express.Router();
const authMiddleware = require('../utils/authMiddleware');
const { createWatchlist, addMovieToWatchlist } = require('../controllers/watchlistController');

router.post('/', createWatchlist);
router.post('/:id/movies', addMovieToWatchlist);

module.exports = router;
