const express = require('express');
const cors = require('cors');
const mysql = require("mysql2");
const bodyParser = require('body-parser');
const port = 3000;

const app = express();
app.use(cors()); // 允许跨域访问
app.use(express.json()); // 解析 JSON 请求

// 创建数据库连接
const db = mysql.createConnection({
    host: 'localhost',
    user: 'root',
    password: 'myfoodchoice',
    database: 'myfoodchoice'
});

// 连接数据库
db.connect((err) => {
    if (err) {
        console.error("数据库连接失败:", err.stack);
        process.exit(1);
    }
    console.log("✅ 数据库连接成功");
});

// 搜索接口
app.get("/api/search", (req, res) => {
    const searchQuery = req.query.query;
    if (!searchQuery) {
        return res.status(400).json({ message: "❌ 搜索参数不能为空" });
    }

    const sql = "SELECT * FROM Recipe WHERE recipe_name LIKE ?";
    db.query(sql, [`%${searchQuery}%`], (error, results) => {
        if (error) {
            return res.status(500).json({ message: "❌ 数据库查询错误" });
        }
        res.json(results);
    });
});

/* 测试数据，用预定义的json数据模拟api请求，测试node.js运行正常以及数据格式无误
// 模拟 API，暂时用来返回默认的推荐菜谱
app.get('/api/recipes', (req, res) => {
    const recipes = [
        { recipe_ID: 1, recipe_name: "Pancakes", instructions: "", image_URL: "123.jpg", traffic_lights: {"Saturates": "green", "Salt": "green", "Sugar": "yellow", "Fat": "yellow"}, food_type: "breakfast", is_recommend: true },
        { recipe_ID: 2, recipe_name: "PorkBurger", instructions: "", image_URL: "https://i2.chuimg.com/d7cb9c0430e34c69aca5f4ac7a2994a6_606w_404h.jpg", traffic_lights: {"Saturates": "green", "Salt": "green", "Sugar": "yellow", "Fat": "yellow"}, food_type: "dinner", is_recommend: true },
        { recipe_ID: 3, recipe_name: "Taco", instructions: "", image_URL: "123.jpg", traffic_lights: {"Saturates": "green", "Salt": "green", "Sugar": "yellow", "Fat": "yellow"}, food_type: "lunch", is_recommend: false },
        { recipe_ID: 4, recipe_name: "Grilled Meat and Egg Salad with Avocado", instructions: "", image_URL: "", traffic_lights: {"Saturates": "green", "Salt": "green", "Sugar": "yellow", "Fat": "yellow"}, food_type: "dinner", is_recommend: true },
	{ recipe_ID: 5, recipe_name: "Pineapple Pizza", instructions: "", image_URL: "", traffic_lights: {"Saturates": "green", "Salt": "green", "Sugar": "yellow", "Fat": "yellow"}, food_type: "snack", is_recommend: true },
	{ recipe_ID: 6, recipe_name: "KFC family value bucket", instructions: "", image_URL: "", traffic_lights: {"Saturates": "green", "Salt": "green", "Sugar": "yellow", "Fat": "yellow"}, food_type: "lunch", is_recommend: true }
    ];
    res.json(recipes);
});
*/

// **查询所有 recommended recipes**
app.get('/api/recipes', (req, res) => {
    db.query('SELECT * FROM Recipe WHERE is_recommend = true;', (error, results) => {
        if (error) {
            console.error('查询错误:', error);
            return res.status(500).json({ message: '数据库查询失败' });
        }

	// **将 is_recommend 变成 true/false**
        results.forEach(recipe => {
            recipe.is_recommend = recipe.is_recommend === 1;
        });
        res.json(results);
    });
});

//搜索功能
app.post("/api/search", (req, res) => {
    const searchQuery = req.body.query;  // ✅ 从 POST body 获取搜索词

    if (!searchQuery) {
        return res.status(400).json({ message: "❌ 搜索参数不能为空" });
    }

    const sql = "SELECT * FROM Recipe WHERE recipe_name LIKE ? ;";
    db.query(sql, [`%${searchQuery}%`], (error, results) => {
	//db.query('SELECT * FROM Recipe WHERE is_recommend = true;', (error, results) =>{
        if (error) {
            return res.status(500).json({ message: "❌ 数据库查询错误" });
        }

	// **将 is_recommend 变成 true/false**
        results.forEach(recipe => {
            recipe.is_recommend = recipe.is_recommend === 1;
        });

        res.json(results);
    });
});

// 启动服务器
app.listen(port, () => {
    console.log(`Server is running at http://localhost:${port}`);
});