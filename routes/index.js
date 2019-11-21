let express = require('express');
let router = express.Router();
const rp = require('request-promise');
const connection=require('./conn');
const request=require('request');
/* GET home page. */
//接收请求
connection.connect(()=>{
    console.log("数据库连接成功")
});
/* GET home page. */
router.get('/', function(req, res, next) {
  res.render('index', { title: 'Express' });
});

router.post('/carousel',function (req,res) {
    let data=[{
        banid:1,
        pic:'1.jpg'
    },{
        banid:2,
        pic:'2.jpg'
    },{
        banid:3,
        pic:'3.jpg'
    }];
    res.send(data)
});
router.post('/project',function (req,res) {
    console.log(req)
    connection.query("select * from doctor",(err,data)=>{
        if(err){
            throw err;
        }else {
            res.send(data);
        }
    })
});
router.post('/findDoctor',function (req,res) {
    connection.query("select * from doctor where exid="+req.body.exid ,(err,data)=>{
        if(err){
            throw err;
        }else {
            res.send(data);
        }
    })
});
router.get("/getOpenId",function (req,res) {
    let {code,appid,secret}=req.query;
    try {
        const options={
            method:'GET',
            url: 'https://api.weixin.qq.com/sns/jscode2session',
            qs: {
                grant_type: 'authorization_code',
                js_code: code,
                secret: secret,
                appid: appid,
            }
        };
        rp(options).then(function (response) {
            console.log(`ServerB responded with statuscode ${response.statusCode}`)
            let data=JSON.parse(response);
            res.send(data.openid)

        }).catch(function (err) {
            console.log(`ServerB responded with error ${err}`)
        })

    }catch(e) {

    }
});
module.exports = router;

  //  'https://api.weixin.qq.com/sns/jscode2session?grant_type=authorization_code&js_code=061h2AF70fIBpF1SBuH70JxEF70h2AFO&secret=0d8949e5dfb19aaefd8f568cdc5d4cdc&appid=wx7d118a6b1b628f42'