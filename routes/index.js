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
    let {code,appid,secret,userInfo}=req.query;
    userInfo=JSON.parse(userInfo)

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

            let data=JSON.parse(response);

            return data

        }).then((data)=>{

            connection.query("select * from username where wx_open_id='"+data.openid+"'" ,(err,se)=>{
                if(err){
                    throw err;
                }else {

                    if(se.length==0){
                        connection.query("insert into username(imgUrl,username,password,phone,wx_open_id) values('"+userInfo.avatarUrl+"','"+userInfo.nickName+"','123456','123','"+data.openid+"')" ,(err,datas)=>{
                            if(err){
                                throw err;
                            }else {
                                let json={
                                    wx_open_id:data.openid,
                                    username:userInfo.nickName,
                                    imgUrl:userInfo.avatarUrl
                                }
                                res.send([json]);
                            }
                        })
                    }else{
                        res.send(se)
                    }

                }
            })
        }).catch(function (err) {

        })

    }catch(e) {

    }
});
router.post('/insertAppointment',(req,res)=>{
    let {doctorid,user_wx_id,year,month,day,time}=req.body;
    connection.query("insert into appointment(doctorid,user_wx_id,year,month,day,time) values(?,?,?,?,?,?)" ,[doctorid,user_wx_id,year,month,day,time],(err,datas)=>{
        if(err){
            throw err;
        }else {

            res.send("成功");
        }
    })
})
router.post('/findOneAppointment',(req,res)=>{
    let {user_wx_id}=req.body;
    console.log(user_wx_id)
    connection.query("select * from appointment where user_wx_id= ?" ,[user_wx_id],(err,datas)=>{
        if(err){
            throw err;
        }else {
            console.log(datas)
            res.send(datas);
        }
    })
})
module.exports = router;

  //  'https://api.weixin.qq.com/sns/jscode2session?grant_type=authorization_code&js_code=061h2AF70fIBpF1SBuH70JxEF70h2AFO&secret=0d8949e5dfb19aaefd8f568cdc5d4cdc&appid=wx7d118a6b1b628f42'