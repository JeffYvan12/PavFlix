// controllers/watchlistController.js
const Watchlist = require('../models/Watchlist.js');
const Movie = require('../models/Movie.js');

exports.createWatchlist = async (req, res) => {
    try {
        const newWatchlist = new Watchlist({
            user: req.body._id,
            name: req.body.name,
            movies: []
        });
        await newWatchlist.save();
        res.status(201).json({ message: "Watchlist created successfully", watchlist: newWatchlist });
    } catch (error) {
        res.status(400).json({ message: error.message });
    }
};

exports.addMovieToWatchlist = async (req, res) => {
    try {
        const watchlist = await Watchlist.findOne({ user: req.body.userid, _id: req.params.id });
        if (!watchlist) return res.status(404).json({ message: "Watchlist not found" });

        const movie = await Movie.findById(req.body.movieId);
        if (!movie) return res.status(404).json({ message: "Movie not found" });

        watchlist.movies.push(movie);
        await watchlist.save();

        res.status(200).json({ message: "Movie added to watchlist", watchlist });
    } catch (error) {
        res.status(400).json({ message: error.message });
    }
};
