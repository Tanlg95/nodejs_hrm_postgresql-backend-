/*
    valid emal;
    valid password;
*/
const statusClass = require('../support/status');
const status = new statusClass();

function validEmail(email)
{
    const regEmail = /[a-zA-Z][a-zA-Z0-9._-]+@[a-zA-Z][a-zA-Z0-9_-]+\.[a-zA-Z][a-zA-Z0-9_-]+(?:\.[a-zA-Z]+)?/g;
    try {
        if(!(regEmail.test(email))) throw status.errorStatus(8);
        return email;
    } catch (error) {
        throw error;
    }
};

function validPassword(password)
{
    /*
        1.at least one uppercase letter
        2.at least one number
        3.at least one lowercase letters
        4.at least one on the list [@!#$%&^]
    */
    const regPassword = /(?=.*[@!#$%&^])(?=.*[A-Z])(?=.*[0-9])(?=.*[a-z])(?!.*[^a-zA-Z0-9@!#$%&^])/g;
    try {
        if(!(regPassword.test(password))) throw status.errorStatus(9);
        return password;
    } catch (error) {
        throw error;
    }
};

module.exports = {
    validEmail: validEmail,
    validPassword: validPassword,
};