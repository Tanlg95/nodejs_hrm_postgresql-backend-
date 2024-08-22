const express = require('express');
const router = express.Router();
const authToken = require('../tokenOperations/jwt').authToken;
const employeeCRUD = require('../postgreOperations/employee/employeeCRUD');
const employeeFunction = require('../postgreOperations/employee/employeeFunction');
const positionCRUD = require('../postgreOperations/position/positionCRUD');
const positionFunction = require('../postgreOperations/position/positionFunction');
const departmentCRUD = require('../postgreOperations/department/departmentCRUD');
const departmentFunction = require('../postgreOperations/department/departmentFunction');
const accountCRUD = require('../postgreOperations/account/accountCRUD');
const accountFunction = require('../postgreOperations/account/accountFunction');


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
router.get('/employee/get',authToken,(req,res,next) =>{
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

//------------------------------ department ----------------------------------//

/* create employee department */
router.post('/department/insert',(req,res,next) =>{

    departmentCRUD.insert_employee_dep(req).then(
        respone => res.json(respone)
    ).catch(
        err => next(err)
    );
});

/* update employee department */
router.post('/department/update',(req,res,next) =>{

    departmentCRUD.update_employee_dep(req).then(
        respone => res.json(respone)
    ).catch(
        err => next(err)
    );
});

/* delete employee department */
router.delete('/department/delete',(req,res,next) =>{
    
    departmentCRUD.delete_employee_dep(req).then(
        respone => res.json(respone)
    ).catch(
        err => next(err)
    );
})

/* get employee department */
router.get('/department/get',(req,res,next) =>{
    const body = req.body;
    departmentFunction.get_employee_dep(body).then(
        respone => res.json(respone)
    ).catch(
        err => next(err)
    );
})


//------------------------------ account ----------------------------------//

/* create account */
router.post('/account/insert',(req,res,next) =>{
    const body = req.body;
    accountCRUD.create_account(body).then(
        respone => res.json(respone)
    ).catch(
        err => next(err)
    );
});

/* update account */
router.post('/account/update',(req,res,next) =>{
    const body = req.body;
    accountCRUD.update_account(body).then(
        respone => res.json(respone)
    ).catch(
        err => next(err)
    );
});

/* delete account */
router.delete('/account/delete',(req,res,next) =>{
    const body = req.body;
    accountCRUD.delete_account(body).then(
        respone => res.json(respone)
    ).catch(
        err => next(err)
    );
})

/* renew token */
router.post('/account/renewtoken',(req,res,next) =>{
    const body = req.body;
    accountCRUD.renewToken(body).then(
        respone => res.json(respone)
    ).catch(
        err => next(err)
    );
})

/* login */
router.post('/account/login',(req,res,next) =>{
    const body = req.body;
    accountFunction.login(body).then(
        respone => res.json(respone)
    ).catch(
        err => next(err)
    );
})

module.exports = router;