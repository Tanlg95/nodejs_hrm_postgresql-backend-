require('dotenv').config();
const express = require('express');
const app = express();
const router = require('./router/router');
const bodyparser = require('body-parser');
const cors = require('cors');

// app.get('/api',(req,res,next) =>{
//     res.send({
//         status:"Ok!",
//         description:"welcome to my hrm project"
//     })
// });

const envir = process.env.ENVIR;
const whitelist = ['https://tanlg.com.vn'];
const corsOptions = {
  origin: function (origin, callback) {
    if (whitelist.indexOf(origin) !== -1 || envir.toLocaleLowerCase() === 'test') {
      callback(null, true)
    } else {
      callback(new Error('Not allowed by CORS'))
    }
  }
}
app.use(cors(corsOptions));
app.use(bodyparser.json());
app.use(bodyparser.urlencoded({extended: true}));
app.use('/api',router);
router.use((req,res,next)=>{
    console.log('middleware!');
    next();
});


const port = process.env.PORT_SERVER || 3333;
app.listen(port,() => console.log(`server is running at port ${port}`));