const pg = require('pg').Pool;
const pg_configure = require('../../postgreConfigure/postgreConnect');
const statusClass = require('../../support/status');
const status = new statusClass();
const bcrypt = require('bcrypt');
const valid = require('../../support/valid');
const token = require('../../tokenOperations/jwt');


// login

async function login(body)
{
    try {
        const connection = new pg(pg_configure);
        const getPassword = await connection.query(`SELECT pwd, accountName FROM employee.tblaccount WHERE accountId = '${body.accountId}'`);
        if(getPassword.rowCount === 0) throw status.errorStatus(2);
        const checkValidPassword = bcrypt.compareSync(valid.validPassword(body.pwd), getPassword.rows[0].pwd);
        if(!checkValidPassword) throw status.errorStatus(2);
        const account = {
            accountId: body.accountId,
            // create token
            accessToken: token.createToken({
                accountId: body.accountId,
                accountName: getPassword.rows[0].accountName,
                email: getPassword.rows[0].email
            },1),
            refreshToken: token.createToken({
                accountId: body.accountId,
                accountName: getPassword.rows[0].accountName,
                email: getPassword.rows[0].email
            },2)
        };
        // encrypt refresh token
        const refreshTokenEnc = bcrypt.hashSync(account.refreshToken, bcrypt.genSaltSync(10));
        const pool = await connection.query(`
            UPDATE employee.tblaccount 
            SET refresh_token = '${refreshTokenEnc}'
            WHERE accountId = '${account.accountId}'
            `); 
        // return account info
        return {
            status: (pool.rowCount === 1) ? status.operationStatus(104) : 'Error',
            accountId: account.accountId,
            accessToken: account.accessToken,
            refreshToken: account.refreshToken
        };
    } catch (error) {
        console.log(error);
        throw error;
    }
}


module.exports = {
    login: login,

}