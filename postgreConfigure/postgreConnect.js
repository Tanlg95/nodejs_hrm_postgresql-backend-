require('dotenv').config();
const configure = {
    user: process.env.USER_POSTGRESQL,
    password: process.env.PASSWORD_POSTGRESQL,
    host: process.env.HOST_POSTGRESQL,
    database: process.env.DATABASE_POSTGRESQL,
    port: Number(process.env.PORT_POSTGRESQL)
};

module.exports = configure;