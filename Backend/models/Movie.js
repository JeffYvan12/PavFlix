// models/Movie.js
const mongoose = require('mongoose');

const movieSchema = new mongoose.Schema({
    title: { type: String, required: true },
    genre: String,
    director: String,
    rating: Number,
    release_date: Date,
    overview: String,
    poster_path: String,
}, { timestamps: true });

module.exports = mongoose.model('Movie', movieSchema);
