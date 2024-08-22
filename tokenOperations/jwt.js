require('dotenv').config();
const jwt = require('jsonwebtoken');
const bcrypt = require('bcrypt');

const createToken = function(payload,opt){

    // access token => opt: 1
    // refresh token => opt: 2
    if(!([1,2].includes(opt))) throw new Error('opt must be in (1,2)');
    try {
        let token = undefined;
        switch(opt)
        {
            case 1:
                token = jwt.sign(payload,process.env.POSTGRE_ACCESSTOKEN,{
                    expiresIn: "30m"
                });
            break;
            case 2:
                token = jwt.sign(payload,process.env.POSTGRE_REFRESHTOKEN,{
                    expiresIn: "60d"
                });
            break;
        }
    return token;
       
    } catch (error) {
        throw error
    }
};

const authToken = function(req,res,next)
{
    try {
        const tokenForAuth = req.body.atoken || req.query.atoken || req.headers["atoken"];
        if(!tokenForAuth) throw new Error('please provide a token for auth');
        const payload = jwt.verify(tokenForAuth, process.env.POSTGRE_ACCESSTOKEN);
        if(!payload) throw new Error('verify error!!!');
        //console.log(payload);
        //res.status(200).send(payload);
        next();
    } catch (error) {
        throw error;    
    }
};

const renewToken = function(atoken_old, ftoken, ftokenEncrypt)
{
    try{
        if(!atoken_old || !ftoken) throw new Error('please provide token!!!');
        // check old access token and old refresh token
        const check_atoken_old = jwt.verify(atoken_old, process.env.POSTGRE_ACCESSTOKEN,{
            ignoreExpiration: true
        });
        console.log(`check: ${check_atoken_old}`);
        const check_ftoken_old = jwt.verify(ftoken, process.env.POSTGRE_REFRESHTOKEN);
        // check refresh token which saved in database
        const check_ftoken_db = bcrypt.compareSync(ftoken, ftokenEncrypt);

        if(!check_atoken_old  || !check_ftoken_old || !check_ftoken_db) throw new Error('error!!! the old token is incorrect')
        // return access token and refresh token
        const payload = {
            accountId: check_ftoken_old.accountId,
            accountName: check_ftoken_old.accountName,
            email: check_ftoken_old.email
        }
        return {
            atoken: createToken(payload,1),
            ftoken: createToken(payload,2)
        }
    }
    catch(err)
    {
        throw err;
    }
}

module.exports = {
    createToken: createToken,
    authToken: authToken,
    renewToken: renewToken
}