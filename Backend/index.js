// index.js
const express = require('express');
const connectDB = require('./config/db');
const authRoutes = require('./routes/authRoutes');
const movieRoutes = require('./routes/movieRoutes');
const watchlistRoutes = require('./routes/watchlistRoutes');
require('dotenv').config();

const app = express();
connectDB();

app.get('/hello',(req,res)=>{
    res.send('Hello Joseph');
 });
app.use(express.json());
app.use('/api/auth', authRoutes);
app.use('/api/movies', movieRoutes);
app.use('/api/watchlist', watchlistRoutes);

const PORT = process.env.PORT || 9304;
app.listen(PORT, () => {
    console.log(`Server running on port ${PORT}`);
});
