const express = require('express');
const mysql = require('mysql2');
const bodyParser = require('body-parser');
const cors = require('cors');

const app = express();
app.use(cors());
app.use(bodyParser.json());

// 创建数据库连接
const db = mysql.createConnection({
    host: 'localhost',
    user: 'root',
    password: 'szzSZZ!350',
    database: 'myfoodchoice'
});

db.connect((err) => {
    if (err) {
        console.error('数据库连接失败:', err.stack);
        process.exit(1);
    }
    console.log('数据库已连接');
});

// 登录接口
app.post('/api/login', (req, res) => {
    const { username, password } = req.body;

    // 查询数据库验证用户
    db.query('SELECT * FROM users_login WHERE username = ? AND password = ?', [username, password], (error, results) => {
        if (error) {
            return res.status(500).json({ message: '数据库错误' });
        }
        if (results.length > 0) {
            return res.status(200).json({ message: '登录成功' });
        } else {
            return res.status(401).json({ message: '用户名或密码错误' });
        }
    });
});

// 添加测试路由
app.get('/api/test', (req, res) => {
    db.query('SELECT 1 + 1 AS solution', (error, results) => {
        if (error) {
            console.error('测试查询失败:', error);
            return res.status(500).json({ message: '数据库测试失败' });
        }
        return res.status(200).json({ 
            message: '数据库测试成功',
            data: results[0].solution 
        });
    });
});

// 添加用户查询测试路由
app.get('/api/users', (req, res) => {
    db.query('SELECT * FROM users_login', (error, results) => {
        if (error) {
            console.error('查询用户失败:', error);
            return res.status(500).json({ message: '查询失败' });
        }
        return res.status(200).json({ 
            message: '查询成功',
            users: results 
        });
    });
});

// 启动服务器
app.listen(3000, () => {
    console.log('服务器正在运行，端口：3000');
}); 