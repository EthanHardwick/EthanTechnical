/**
 * Created by jesus.cantero on 13/05/2021.
 */

({
    init: function (cmp, event, helper) {
        cmp.set('v.columns', [
            {label: 'Id', fieldName: 'id', type: 'text'},
            {label: 'Name', fieldName: 'name', type: 'text'},
            {label: 'UserName', fieldName: 'userName', type: 'text'},
            {label: 'Email', fieldName: 'email', type: 'email'},
            {label: 'Company Name', fieldName: 'company', type: 'text'}
        ]);
    }
});