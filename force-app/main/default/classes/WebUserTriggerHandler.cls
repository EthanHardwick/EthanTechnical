public with sharing class WebUserTriggerHandler {

    public static void checkForPremiumCompany(List<Web_User__c> newList){
      Set<String> premiumCompanySet = new Set<String>();
      for (Premium_Company__mdt premiumCompany : Premium_Company__mdt.getAll().values()) {
        premiumCompanySet.add(premiumCompany.label);
      }
      for (Web_User__c webUser : newList) {
        if(webUser.Company__c == null){
          continue;
        }
        if(premiumCompanySet.contains(webUser.Company__c)){
          webUser.IsPremium__c = true;
        }
      }
    }
}
