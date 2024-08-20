const pg = require('pg').Pool;
const pg_configure = require('../../postgreConfigure/postgreConnect');
const statusClass = require('../../support/status');
const status = new statusClass();


// insert employee information
async function insert_employee_info(body)
{
    const connection = new pg(pg_configure);
    try {
        if(!(body.body instanceof Array)) throw status.errorStatus(1);
        const employee_input = body.body;
        let format_insert_query = '';
        for(let ele of employee_input)
        {
            format_insert_query += 
            `('${ele.employeeId}',
            '${ele.employeeName}',
            '${ele.employedDate}',
            '${ele.birthDate}',
            '${ele.cellPhone}',
            '${ele.address}',
            '${ele.address_tmp}',
            '${ele.isActive}'
            ),`
        }
        format_insert_query = format_insert_query.slice(0, format_insert_query.length - 1);
        format_insert_query = 'INSERT INTO employee.tblemployee(employeeId, employeeName, employedDate, birthDate, cellPhone, address, address_tmp, isActive) VALUES' + format_insert_query;
        const pool = await connection.query(format_insert_query);
        return pool.rows;
    } catch (error) {
        console.log(error);
        throw error;
    }
};

// update employee information
async function update_employee_info(body)
{
    const connection = new pg(pg_configure);
    try {
        if(!(body.body instanceof Array)) throw status.errorStatus(1);
        const employee_input = body.body;
        let format_insert_query = '';
        for(let ele of employee_input)
        {
            format_insert_query += 
            `UPDATE employee.tblemployee
                SET 
                employeeName = '${ele.employeeName}',
                employedDate = '${ele.employedDate}',
                birthDate = '${ele.birthDate}',
                cellPhone = '${ele.cellPhone}',
                address = '${ele.address}',
                address_tmp = '${ele.address_tmp}',
                isActive = '${ele.isActive}'
            WHERE employeeId = '${ele.employeeId}';
            `
        }
        format_insert_query = `BEGIN; ` + format_insert_query + ` COMMIT;`;
        const pool = await connection.query(format_insert_query);
        return pool.rows;
    } catch (error) {
        console.log(error);
        throw error;
    }
};

// delete employee information
async function delete_employee_info(body)
{
    const connection = new pg(pg_configure);
    try {
        if(!(body.body instanceof Array)) throw status.errorStatus(1);
        const employee_input = body.body;
        let format_insert_query = '';
        for(let ele of employee_input)
        {
            format_insert_query += `'${ele.employeeId}',`
        }
        format_insert_query = format_insert_query.slice(0, format_insert_query.length - 1);
        format_insert_query = `DELETE FROM employee.tblemployee WHERE employeeId IN(${format_insert_query});`;
        const pool = await connection.query(format_insert_query);
        return pool.rows;
    } catch (error) {
        console.log(error);
        throw error;
    }
};

module.exports = {
    insert_employee_info: insert_employee_info,
    update_employee_info: update_employee_info,
    delete_employee_info: delete_employee_info,

};