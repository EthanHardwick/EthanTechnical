import { LightningElement } from 'lwc';

const COLUMNS = [
            {label: 'Id', fieldName: 'id', type: 'text'},
            {label: 'Name', fieldName: 'name', type: 'text'},
            {label: 'UserName', fieldName: 'userName', type: 'text'},
            {label: 'Email', fieldName: 'email', type: 'email'},
            {label: 'Company Name', fieldName: 'company', type: 'text'}
        ]
export default class MissingWebUserListLwc extends LightningElement {

  get columns(){
    return COLUMNS;
  }
}
