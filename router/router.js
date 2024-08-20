const express = require('express');
const router = express.Router();
const employeeCRUD = require('../postgreOperations/employee/employeeCRUD');
const employeeFunction = require('../postgreOperations/employee/employeeFunction');
const positionCRUD = require('../postgreOperations/position/positionCRUD');
const positionFunction = require('../postgreOperations/position/positionFunction');

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



//------------------------------ position ----------------------------------//

/* create employee position */
router.post('/position/insert',(req,res,next) =>{

    positionCRUD.insert_employee_pos(req).then(
        respone => res.json(respone)
    ).catch(
        err => next(err)
    );
});

/* update employee position */
router.post('/position/update',(req,res,next) =>{

    positionCRUD.update_employee_pos(req).then(
        respone => res.json(respone)
    ).catch(
        err => next(err)
    );
});

/* delete employee position */
router.delete('/position/delete',(req,res,next) =>{
    
    positionCRUD.delete_employee_pos(req).then(
        respone => res.json(respone)
    ).catch(
        err => next(err)
    );
})

/* get employee position */
router.get('/position/get',(req,res,next) =>{
    const body = req.body;
    positionFunction.get_employee_pos(body).then(
        respone => res.json(respone)
    ).catch(
        err => next(err)
    );
})



module.exports = router;