/**
 * Created by jesus.cantero on 13/05/2021.
 */

public with sharing class MissingWebUserListCtrl {

  @AuraEnabled(cacheable=true)
  public static List<Web_User__c> fetchMissingUsers(){
    List<Web_User__c> webUsers = new List<Web_User__c>();
    try {
      for (WebUserExternalApiService.WebUserResponseWrapper webUser : new WebUserExternalApiService().doCallout()) {
        webUsers.add(new Web_User__c(
          Name = webUser.name,
          Web_Site_Id__c = webUser.id,
          Username__c = webUser.username,
          Company__c = webUser.company.name,
          Email__c = webUser.email
        ));
      }
    } catch (Exception error) {
      AuraHandledException handledException = new AuraHandledException(error.getMessage());
      handledException.setMessage(error.getMessage());
      throw handledException;
    }
    return webUsers;
  }

  @AuraEnabled
  public static List<Web_User__c> importMissingWebUsers(List<Web_User__c> webUsers){
    List<Web_User__c> failedWebUserInserts = new List<Web_User__c>();
    try {
      Database.SaveResult[] saveResults = Database.insert(webUsers, false);
      for (Web_User__c webUser : webUsers) {
        if(webUser.Id == null){
          failedWebUserInserts.add(webUser);
        }
      }
    } catch (Exception error) {
      AuraHandledException handledException = new AuraHandledException(error.getMessage());
      handledException.setMessage(error.getMessage());
      throw handledException;
    }
    System.debug(failedWebUserInserts);
    return failedWebUserInserts;
  }
}
