const pg = require('pg').Pool;
const pg_configure = require('../../postgreConfigure/postgreConnect');
const statusClass = require('../../support/status');
const status = new statusClass();


// get employee position
async function get_employee_pos(body)
{
   try {
    const parameter = {
        empid: (!(body.empid))? null : `'${body.empid}'` ,
        todate: (!(body.todate))? null : `'${body.todate}'` 
    }
    const connection = new pg(pg_configure);
    const pool = await connection.query(
        `SELECT employeeId, dateChange, posId, posName, note
         FROM employee.ufn_getcurr_pos(${parameter.todate},${parameter.empid})`
    );
    return pool.rows;
   } catch (error) {
        console.log(error);
        throw error;
   }
};


module.exports = {
    get_employee_pos: get_employee_pos,

}