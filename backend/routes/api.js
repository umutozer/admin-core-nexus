const express = require('express');
const router = express.Router();
const mainController = require('../controllers/mainController');

// Dashboard İstatistikleri
router.get('/dashboard/stats', mainController.getDashboardStats);
router.get('/dashboard/activity', mainController.getActivityChart);

// Kullanıcı Yönetimi
router.get('/users', mainController.getUsers);
router.post('/users', mainController.createUser);
router.put('/users/:id', mainController.updateUser);
router.delete('/users/:id', mainController.deleteUser);

// Ürün Yönetimi
router.get('/products', mainController.getProducts);
router.post('/products', mainController.createProduct);
router.get('/categories', mainController.getCategories);

module.exports = router;