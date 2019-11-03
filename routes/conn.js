let mysql =require('mysql');
let connection=mysql.createConnection({
    host:'localhost',
    user:'root',
    password:'5928647200',
    database:'vuexms'
})
module.exports=connection;