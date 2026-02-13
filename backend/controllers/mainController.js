const { Pool } = require('pg');

// Veritabanı bağlantı havuzu
const pool = new Pool({
  connectionString: process.env.DATABASE_URL,
  ssl: process.env.NODE_ENV === 'production' ? { rejectUnauthorized: false } : false
});

const mainController = {
  // Dashboard Stats
  getDashboardStats: async (req, res) => {
    try {
      const userCount = await pool.query('SELECT COUNT(*) FROM users');
      const productCount = await pool.query('SELECT COUNT(*) FROM products');
      const monthlySales = await pool.query("SELECT SUM(total_amount) FROM sales WHERE sale_date > NOW() - INTERVAL '30 days'");
      
      res.status(200).json({
        success: true,
        data: {
          totalUsers: parseInt(userCount.rows[0].count),
          totalProducts: parseInt(productCount.rows[0].count),
          monthlySales: parseFloat(monthlySales.rows[0].sum || 0)
        }
      });
    } catch (error) {
      res.status(500).json({ success: false, message: error.message });
    }
  },

  // Activity Chart Data
  getActivityChart: async (req, res) => {
    try {
      const query = `
        SELECT DATE_TRUNC('day', sale_date) as date, SUM(total_amount) as amount 
        FROM sales 
        GROUP BY date 
        ORDER BY date DESC LIMIT 7`;
      const result = await pool.query(query);
      res.status(200).json({ success: true, data: result.rows });
    } catch (error) {
      res.status(500).json({ success: false, message: error.message });
    }
  },

  // User CRUD
  getUsers: async (req, res) => {
    try {
      const result = await pool.query('SELECT id, full_name, email, role, status, created_at FROM users ORDER BY created_at DESC');
      res.status(200).json({ success: true, data: result.rows });
    } catch (error) {
      res.status(500).json({ success: false, message: error.message });
    }
  },

  createUser: async (req, res) => {
    const { full_name, email, role, password_hash } = req.body;
    try {
      const result = await pool.query(
        'INSERT INTO users (full_name, email, role, password_hash) VALUES ($1, $2, $3, $4) RETURNING id, full_name, email, role',
        [full_name, email, role, password_hash]
      );
      res.status(201).json({ success: true, data: result.rows[0], message: 'Kullanıcı başarıyla oluşturuldu.' });
    } catch (error) {
      res.status(400).json({ success: false, message: error.message });
    }
  },

  updateUser: async (req, res) => {
    const { id } = req.params;
    const { full_name, role, status } = req.body;
    try {
      const result = await pool.query(
        'UPDATE users SET full_name = $1, role = $2, status = $3, updated_at = CURRENT_TIMESTAMP WHERE id = $4 RETURNING *',
        [full_name, role, status, id]
      );
      res.status(200).json({ success: true, data: result.rows[0], message: 'Kullanıcı güncellendi.' });
    } catch (error) {
      res.status(400).json({ success: false, message: error.message });
    }
  },

  deleteUser: async (req, res) => {
    const { id } = req.params;
    try {
      await pool.query('DELETE FROM users WHERE id = $1', [id]);
      res.status(200).json({ success: true, message: 'Kullanıcı silindi.' });
    } catch (error) {
      res.status(500).json({ success: false, message: error.message });
    }
  },

  // Product CRUD
  getProducts: async (req, res) => {
    try {
      const result = await pool.query(`
        SELECT p.*, c.name as category_name 
        FROM products p 
        LEFT JOIN categories c ON p.category_id = c.id 
        ORDER BY p.created_at DESC`);
      res.status(200).json({ success: true, data: result.rows });
    } catch (error) {
      res.status(500).json({ success: false, message: error.message });
    }
  },

  createProduct: async (req, res) => {
    const { name, slug, price, stock_quantity, category_id, sku } = req.body;
    try {
      const result = await pool.query(
        'INSERT INTO products (name, slug, price, stock_quantity, category_id, sku) VALUES ($1, $2, $3, $4, $5, $6) RETURNING *',
        [name, slug, price, stock_quantity, category_id, sku]
      );
      res.status(201).json({ success: true, data: result.rows[0], message: 'Ürün eklendi.' });
    } catch (error) {
      res.status(400).json({ success: false, message: error.message });
    }
  },

  getCategories: async (req, res) => {
    try {
      const result = await pool.query('SELECT * FROM categories');
      res.status(200).json({ success: true, data: result.rows });
    } catch (error) {
      res.status(500).json({ success: false, message: error.message });
    }
  }
};

module.exports = mainController;