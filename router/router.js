const express = require('express');
const router = express.Router();
const employeeCRUD = require('../postgreOperations/employee/employeeCRUD');
const employeeFunction = require('../postgreOperations/employee/employeeFunction');

//------------------------------ employee ----------------------------------//

/* create employee information */
router.post('/employee/insert',(req,res,next) =>{

    employeeCRUD.insert_employee_info(req).then(
        respone => res.json(respone)
    ).catch(
        err => next(err)
    );
});

/* update employee information */
router.post('/employee/update',(req,res,next) =>{

    employeeCRUD.update_employee_info(req).then(
        respone => res.json(respone)
    ).catch(
        err => next(err)
    );
});

/* delete employee information */
router.delete('/employee/delete',(req,res,next) =>{
    
    employeeCRUD.delete_employee_info(req).then(
        respone => res.json(respone)
    ).catch(
        err => next(err)
    );
})

/* get employee information */
router.get('/employee/get',(req,res,next) =>{
    const body = req.body;
    employeeFunction.get_employee_info(body).then(
        respone => res.json(respone)
    ).catch(
        err => next(err)
    );
})



module.exports = router;