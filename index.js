require('dotenv').config();
const express = require('express');
const app = express();
const router = require('./router/router');
const bodyparser = require('body-parser');

// app.get('/api',(req,res,next) =>{
//     res.send({
//         status:"Ok!",
//         description:"welcome to my hrm project"
//     })
// });

app.use(bodyparser.json());
app.use(bodyparser.urlencoded({extended: true}));
app.use('/api',router);
router.use((req,res,next)=>{
    console.log('middleware!');
    next();
});


const port = process.env.PORT_SERVER || 3333;
app.listen(port,() => console.log(`server is running at port ${port}`));