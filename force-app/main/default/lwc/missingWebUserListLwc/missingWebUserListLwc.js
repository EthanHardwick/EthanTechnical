import { LightningElement, wire } from 'lwc';
import { ShowToastEvent } from "lightning/platformShowToastEvent";
import fetchMissingUsers from '@salesforce/apex/MissingWebUserListCtrl.fetchMissingUsers';
import importMissingWebUsers from '@salesforce/apex/MissingWebUserListCtrl.importMissingWebUsers';

const COLUMNS = [
  {label: 'Id', fieldName: 'Web_Site_Id__c', type: 'text'},
  {label: 'Name', fieldName: 'Name', type: 'text'},
  {label: 'UserName', fieldName: 'Username__c', type: 'text'},
  {label: 'Email', fieldName: 'Email__c', type: 'email'},
  {label: 'Company Name', fieldName: 'Company__c', type: 'text'}
]

export default class MissingWebUserListLwc extends LightningElement {

  data = [];
  spinnerActive = true;

  @wire(fetchMissingUsers)
  getMissingWebUsers({error, data}){
    if (data) {
      this.data = data;
      this.spinnerActive = false;
    } else if (error) {
      this.showNotification('An error occurred when fetching users', error.body.message, 'error');
    }
  }

  submitMissingRecords(){
    this.spinnerActive = true;
    importMissingWebUsers({ webUsers : this.data}).then(failedWebUserInserts =>{
      this.spinnerActive = false;
      if (failedWebUserInserts.length === 0) {
        this.showNotification('Accounts submitted Successfully',null, 'success');
        this.data = failedWebUserInserts;
      } else {
        this.showNotification('Records with duplicate values for Web_Site_Id__c found',`${this.data.length - failedWebUserInserts.length} Accounts submitted Successfully.`, 'warning');
        this.data = failedWebUserInserts;
      }
    }).catch(error =>{
      this.showNotification('An error occurred when importing users', null, 'error');
    });
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

    get columns(){
      return COLUMNS;
    }
}
