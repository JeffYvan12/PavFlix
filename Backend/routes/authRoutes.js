// routes/authRoutes.js
const express = require('express');
const router = express.Router();
const { register, login,getUser,getAllUsers } = require('../controllers/authController');

router.post('/register', register);
router.post('/login', login);
router.get('/:id',getUser)
router.get('/',getAllUsers);

module.exports = router;
