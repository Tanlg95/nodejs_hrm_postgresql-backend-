const pg = require('pg').Pool;
const pg_configure = require('../../postgreConfigure/postgreConnect');
const statusClass = require('../../support/status');
const status = new statusClass();


// insert employee department
async function insert_employee_dep(body)
{
    const connection = new pg(pg_configure);
    try {
        if(!(body.body instanceof Array)) throw status.errorStatus(1);
        const employee_input = (body.body).map( function(ele){
                const eleFormat = {
                    employeeId: ele.employeeId,
                    dateChange: (!ele.dateChange)? new Date().toISOString().split('T')[0] : ele.dateChange,
                    depId: ele.depId,
                    note: (!ele.note) ? null :  ele.note
                };
                return eleFormat;
        });
        let format_insert_query = '';
        for(let ele of employee_input)
        {
            format_insert_query += 
            `('${ele.employeeId}',
            '${ele.dateChange}',
            '${ele.depId}',
            '${ele.note}'
            ),`
        }
        
        format_insert_query = format_insert_query.slice(0, format_insert_query.length - 1);
        format_insert_query = 'INSERT INTO employee.tblempdep(employeeId, dateChange, depId, note) VALUES' + format_insert_query;
        const pool = await connection.query(format_insert_query);
        return {
            status: status.operationStatus(104),
            totalRowInserted: pool.rowCount
        };
    } catch (error) {
        console.log(error);
        throw error;
    }
};

// update employee department
async function update_employee_dep(body)
{
    const connection = new pg(pg_configure);
    try {
        if(!(body.body instanceof Array)) throw status.errorStatus(1);
        const employee_input = (body.body).map( function(ele){
            const eleFormat = {
                keyid: ele.keyid,
                dateChange: (!ele.dateChange)? new Date().toISOString().split('T')[0] : ele.dateChange,
                depId: ele.depId,
                note: (!ele.note) ? null :  ele.note
            };
            return eleFormat;
    });
        let format_insert_query = '';
        for(let ele of employee_input)
        {
            format_insert_query += 
            `UPDATE employee.tblempdep
                SET 
                dateChange = '${ele.dateChange}',
                depId = '${ele.depId}',
                note = '${ele.note}'
            WHERE keyid = '${ele.keyid}';
            `
        }
        format_insert_query = `BEGIN; ` + format_insert_query + ` COMMIT;`;
        const pool = await connection.query(format_insert_query);
        return {
            status: status.operationStatus(104),
            totalRowModified: pool.filter(ele => ele.command === 'UPDATE' && ele.rowCount === 1).length
        };
    } catch (error) {
        console.log(error);
        throw error;
    }
};

// delete employee department
async function delete_employee_dep(body)
{
    const connection = new pg(pg_configure);
    try {
        if(!(body.body instanceof Array)) throw status.errorStatus(1);
        const employee_input = body.body;
        let format_insert_query = '';
        for(let ele of employee_input)
        {
            format_insert_query += `'${ele.keyid}',`
        }
        format_insert_query = format_insert_query.slice(0, format_insert_query.length - 1);
        format_insert_query = `DELETE FROM employee.tblempdep WHERE keyid IN(${format_insert_query});`;
        const pool = await connection.query(format_insert_query);
        return {
            status: status.operationStatus(104),
            totalRowDeleted: pool.rowCount
        };
    } catch (error) {
        console.log(error);
        throw error;
    }
};

module.exports = {
    insert_employee_dep: insert_employee_dep,
    update_employee_dep: update_employee_dep,
    delete_employee_dep: delete_employee_dep,

};