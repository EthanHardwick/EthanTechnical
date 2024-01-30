import { LightningElement, wire } from 'lwc';
import { ShowToastEvent } from "lightning/platformShowToastEvent";
import fetchMissingUsers from '@salesforce/apex/MissingWebUserListCtrl.fetchMissingUsers';

const COLUMNS = [
            {label: 'Id', fieldName: 'id', type: 'text'},
            {label: 'Name', fieldName: 'name', type: 'text'},
            {label: 'UserName', fieldName: 'userName', type: 'text'},
            {label: 'Email', fieldName: 'email', type: 'email'},
            {label: 'Company Name', fieldName: 'companyName', type: 'text'}
        ]

export default class MissingWebUserListLwc extends LightningElement {

  data = [];
  spinnerActive = true;

  @wire(fetchMissingUsers, {})
  getMissingWebUsers({error, data}){
    if (data) {
      this.data = data;
      this.spinnerActive = false;
    } else if (error) {
      this.showNotification('An error occurred when fetching users', error.body.message, 'error');
    }
  }

  get columns(){
    return COLUMNS;
  }

  showNotification(title, message, variant) {
    this.dispatchEvent(
        new ShowToastEvent({
        title: title,
        message: message,
        variant: variant,
      })
    );
  }
}
