const pg = require('pg').Pool;
const pg_configure = require('../../postgreConfigure/postgreConnect');
const statusClass = require('../../support/status');
const status = new statusClass();
const bcrypt = require('bcrypt');
const valid = require('../../support/valid');
const token = require('../../tokenOperations/jwt');



// create account

async function create_account(body)
{
    try {
        const connection = new pg(pg_configure);
        const accountInput = {
            accountId: body.accountId,
            accountName: body.accountName,
            // valid email
            email: valid.validEmail(body.email),
            // valid password & hash password
            pwd: bcrypt.hashSync(valid.validPassword(body.pwd), bcrypt.genSaltSync(10)),
        };
        const pool = await connection.query(`
            INSERT INTO employee.tblaccount(accountId, accountName, email, pwd)
            VALUES('${accountInput.accountId}', '${accountInput.accountName}', '${accountInput.email}', '${accountInput.pwd}');
            `); 
        // return account info
        return {
            status: (pool.rowCount === 1) ? status.operationStatus(104) : 'Error',
            accountId: accountInput.accountId
        };
    } catch (error) {
        console.log(error);
        throw error;
    }
}

// update account

async function update_account(body)
{
    try {
        const connection = new pg(pg_configure);
        let password = undefined;
        // change password
        if(body.pwd && body.pwdOld)
        {   
            // get encrypted password from database
            const getPassword = await connection.query(`SELECT pwd FROM employee.tblaccount WHERE keyid = ${body.keyid}`);
            if(getPassword.rowCount === 1)
            {
                // check valid old password
                const checkVaidPassword = bcrypt.compareSync(body.pwdOld, getPassword.rows[0].pwd);
                if(!checkVaidPassword) throw status.errorStatus(3);
                // create new password
                password = bcrypt.hashSync(valid.validPassword(body.pwd), bcrypt.genSaltSync(10));
            }
        }
        const accountInput = {
            keyid : body.keyid,
            accountName: (!body.accountName) ? null : `'${[body.accountName]}'`,
            // valid email
            email: (!body.email) ? null : `'${valid.validEmail(body.email)}'`,
            // valid password & hash password
            pwd: (!password) ? null : `'${password}'`
        };
        const pool = await connection.query(`
                CALL employee.usp_update_account(${accountInput.keyid}, ${accountInput.accountName}, ${accountInput.email}, ${accountInput.pwd});
            `);
        return {
            status: status.operationStatus(104)
        };
    } catch (error) {
        console.log(error);
        throw error;
    }
}

// renew access token

async function renewToken(body)
{
    try {
        const connection = new pg(pg_configure);
        const refreshTokenEnc = await connection.query(`SELECT refresh_token FROM employee.tblaccount WHERE keyid = ${body.keyid}`);
        if(refreshTokenEnc.rowCount === 0) throw new Error('incorrect keyid !!!');
        const tokenInfo = {
            // old access token ( expired )
            accessTokenCurr: body.accessToken,
            // current refresh token ( saved in cookie http-only )
            refreshTokenCurr: body.refreshToken,
            // refresh token in database
            refreshTokenEnc: refreshTokenEnc.rows[0].refresh_token
        };
        const newToken = token.renewToken(tokenInfo.accessTokenCurr, tokenInfo.refreshTokenCurr, tokenInfo.refreshTokenEnc);
        return newToken;
    } catch (error) {
        console.log(error);
        throw error;
    }
}


// delete account

async function delete_account(body)
{
    try {
        const connection = new pg(pg_configure);
        const pool = await connection.query(`CALL employee.usp_delete_account(${body.keyid})`);
        return {
            status: status.operationStatus(104)
        };
    } catch (error) {
        console.log(error);
        throw error;
    }
}

module.exports = {
    create_account : create_account,
    update_account : update_account,
    delete_account : delete_account,
    renewToken: renewToken

};