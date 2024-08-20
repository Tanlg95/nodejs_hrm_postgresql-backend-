
/* status type code
    --- 1: the collection has been created
    --- 2: the collection has been
    --- 3: incorrect password or _id
    --- 4: incorrect verification token 
    --- 5: please provide a token
    --- 6: incorrect old access token or refresh token
    --- 7: opt must be in (...)
    --- 8: incorrect email format
    --- 9: incorrect password format

    --- 100: collection has been created
    --- 101: collection has been modified
    --- 102: logged in successfully
    --- 103: password has been changed
    --- 104: Ok
*/

class status {
    // constructor(statusCodeType){
    //     this.statusId = statusCodeType;
    // }
    constructor(){}

    errorStatus(errCode, arrOpt)
    {
        const listErrCode = [1,2,3,4,5,6,7,8,9];
        if(!(listErrCode.includes(errCode))) throw new Error(`incorrect opt!!! must be in (${listErrCode})`);
        const optStatus = (arrOpt instanceof Array) ? arrOpt : '';
        let errOutput = new Error(`undefined error !!!`);
        switch(errCode)
        {
            case 1:
                errOutput = new Error(`Input must be an array !!!`);
                break;
            case 2:
                errOutput = new Error(`Incorrect password or account Id !!!`);
                break;
            case 3:
                errOutput = new Error(`Incorrect password or _id !!!`);
                break;
            case 4:
                errOutput = new Error(`Incorrect verification token !!!`);
                break;
            case 5:
                errOutput = new Error(`Please provide a token !!!`);
                break;
            case 6:
                errOutput = new Error(`Incorrect old access token or refresh token !!!`);
                break;
            case 7:
                errOutput = new Error(`opt must be in (${optStatus}) !!!`);
                break;
            case 8:
                errOutput = new Error(`Incorrect email format !!!`);
                break; 
            case 9:
                errOutput = new Error(`Incorrect password format !!!`);
                break;      
        }
        return errOutput;
    }
    
    operationStatus(opCode){

        const listOpCode = [100,101,102,103,104];
        let operationsStatusName = '';
        if(!(listOpCode.includes(opCode))) throw new Error(`incorrect opt!!! must be in (${listOpCode})`);
        switch(opCode)
        {
            case 100:
                operationsStatusName = 'The collection has been created !!!';
                break;
            case 101:
                operationsStatusName = 'The collection has been modified !!!';
                break;
            case 102:
                operationsStatusName = 'Logged in successfully !!!';
                break;
            case 103:
                operationsStatusName = 'Password has been changed !!!';
                break;
            case 104: 
                operationsStatusName = 'Ok';
                break;
        }
        return operationsStatusName;
    }
};


module.exports = status;