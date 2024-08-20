const pg = require('pg').Pool;
const pg_configure = require('../../postgreConfigure/postgreConnect');
const statusClass = require('../../support/status');
const status = new statusClass();


// insert employee position
async function insert_employee_pos(body)
{
    const connection = new pg(pg_configure);
    try {
        if(!(body.body instanceof Array)) throw status.errorStatus(1);
        const employee_input = (body.body).map( function(ele){
                const eleFormat = {
                    employeeId: ele.employeeId,
                    dateChange: (!ele.dateChange)? new Date().toISOString().split('T')[0] : ele.dateChange,
                    posId: ele.posId,
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
            '${ele.posId}',
            '${ele.note}'
            ),`
        }
        format_insert_query = format_insert_query.slice(0, format_insert_query.length - 1);
        format_insert_query = 'INSERT INTO employee.tblemppos(employeeId, dateChange, posId, note) VALUES' + format_insert_query;
        const pool = await connection.query(format_insert_query);
        return pool.rows;
    } catch (error) {
        console.log(error);
        throw error;
    }
};

// update employee position
async function update_employee_pos(body)
{
    const connection = new pg(pg_configure);
    try {
        if(!(body.body instanceof Array)) throw status.errorStatus(1);
        const employee_input = (body.body).map( function(ele){
            const eleFormat = {
                keyid: ele.keyid,
                dateChange: (!ele.dateChange)? new Date().toISOString().split('T')[0] : ele.dateChange,
                posId: ele.posId,
                note: (!ele.note) ? null :  ele.note
            };
            return eleFormat;
    });
        let format_insert_query = '';
        for(let ele of employee_input)
        {
            format_insert_query += 
            `UPDATE employee.tblemppos
                SET 
                dateChange = '${ele.dateChange}',
                posId = '${ele.posId}',
                note = '${ele.note}'
            WHERE keyid = '${ele.keyid}';
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

// delete employee position
async function delete_employee_pos(body)
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
        format_insert_query = `DELETE FROM employee.tblemppos WHERE keyid IN(${format_insert_query});`;
        const pool = await connection.query(format_insert_query);
        return pool.rows;
    } catch (error) {
        console.log(error);
        throw error;
    }
};

module.exports = {
    insert_employee_pos: insert_employee_pos,
    update_employee_pos: update_employee_pos,
    delete_employee_pos: delete_employee_pos,

};