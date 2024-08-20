const pg = require('pg').Pool;
const pg_configure = require('../../postgreConfigure/postgreConnect');
const statusClass = require('../../support/status');
const status = new statusClass();


// get employee information
async function get_employee_info(body)
{
   try {
    const parameter = {
        empid: (!(body.empid))? null : `'${body.empid}'` ,
        todate: (!(body.todate))? null : `'${body.todate}'` 
    }
    const connection = new pg(pg_configure);
    const pool = await connection.query(
        `SELECT E.employeeId, E.employeeName, E.employedDate, E.birthDate, E.cellPhone, E.address, E.address_tmp, E.isActive, E.keyid
		 FROM employee.ufn_get_employee(${parameter.empid},${parameter.todate}) E`
    );
    return pool.rows;
   } catch (error) {
        console.log(error);
        throw error;
   }
};


module.exports = {
    get_employee_info: get_employee_info,

}