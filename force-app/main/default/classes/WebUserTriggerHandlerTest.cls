@IsTest
public with sharing class WebUserTriggerHandlerTest {

  @TestSetup
  static void setupData(){

  }

  @IsTest
  public static void testCheckForPremiumCompany(){
    List<Web_User__c> webUsersToInsert = new List<Web_User__c>();
    List<Premium_Company__mdt> premiumCompanies = Premium_Company__mdt.getAll().values();
    webUsersToInsert.add(new Web_User__c(Name = 'TestPremium', Email__c='Test@Testing.com', Company__c = premiumCompanies[0].label));
    webUsersToInsert.add(new Web_User__c(Name = 'Test', Email__c='Test@Testing.com', Company__c = 'Test company'));
    webUsersToInsert.add(new Web_User__c(Name = 'Test', Email__c='Test@Testing.com', Company__c = ''));

    Test.startTest();
    insert webUsersToInsert;
    Test.stopTest();

    Web_User__c premiumCompanyUser;
    Web_User__c nonPremiumCompanyUser;

    for (Web_User__c webUser : [SELECT Name, IsPremium__c FROM Web_User__c]) {
      if (webUser.Name == 'TestPremium') {
        premiumCompanyUser = webUser;
      } else {
        nonPremiumCompanyUser = webUser;
      }
    }

    System.assertEquals(true, premiumCompanyUser.IsPremium__c, 'isPremium should be true');
    System.assertEquals(false, nonPremiumCompanyUser.IsPremium__c, 'isPremium should be false');
  }
}
