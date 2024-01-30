/**
 * Created by jesus.cantero on 13/05/2021.
 */

trigger WebUserTrigger on Web_User__c (before insert) {
  if (Trigger.isBefore){
    WebUserTriggerHandler.checkForPremiumCompany((List<Web_User__c>)Trigger.new);
  }
}
