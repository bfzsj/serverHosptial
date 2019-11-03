let express = require('express');
let router = express.Router();
const connection=require('./conn');
/* GET home page. */
//接收请求
connection.connect(()=>{
    console.log("数据库连接成功")
})
router.post('/checklogin',(req,res)=>{
    let mObj = {};
    for (let obj in req.body) {
        mObj = JSON.parse(obj);
        console.log(mObj);
    }
    //执行sql查询
    const sqlStr=`select * from users where username='${mObj.username}' and password='${mObj.password}'`;
    connection.query(sqlStr,(err,data)=>{
        if(err){
            throw err;
        }else{
            res.send(data);
    }
    })
    });
    router.get('/getuserlist',(req,res)=>{
        const sqlget='select * from users';
    connection.query(sqlget,(err,data)=>{
        if(err){
            throw err;
        }else{
            res.send(data)
    }
    })
})
/* GET home page. */
router.get('/', function(req, res, next) {
  res.render('index', { title: 'Express' });
});

module.exports = router;
