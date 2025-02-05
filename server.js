require('dotenv').config();
const express = require('express');
const mongoose = require('mongoose');
const cors = require('cors');

const app = express();
const PORT = process.env.PORT || 3000;
const MONGO_URI = process.env.MONGO_URI || 'mongodb://localhost:27017/userdb';

// 中间件
app.use(cors());
app.use(express.json());

// 连接 MongoDB
mongoose.connect(MONGO_URI, { useNewUrlParser: true, useUnifiedTopology: true })
  .then(() => console.log('MongoDB 连接成功'))
  .catch(err => console.error('MongoDB 连接失败:', err));

// 定义用户数据模型
const UserSchema = new mongoose.Schema({
  zhanghao: String,
  mima: String
});
const User = mongoose.model('User', UserSchema);

// 登录接口
app.get('/find/:zhanghao/:mima', async (req, res) => {
  const { zhanghao, mima } = req.params;
  
  try {
    const user = await User.findOne({ zhanghao, mima });

    if (user) {
      res.json({ success: true, message: '登录成功', data: zhanghao });
    } else {
      res.json({ success: false, message: '用户名或密码错误' });
    }
  } catch (error) {
    console.error('查询错误:', error);
    res.status(500).json({ success: false, message: '服务器错误' });
  }
});

// 服务器启动
app.listen(PORT, () => {
  console.log(`服务器运行在 http://localhost:${PORT}`);
});
