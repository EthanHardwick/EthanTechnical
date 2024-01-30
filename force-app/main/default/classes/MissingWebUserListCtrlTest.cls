@IsTest
public with sharing class MissingWebUserListCtrlTest {

    @TestSetup
    public static void setupData(){
      Web_User_Endpoint__c testEndpoint = new Web_User_Endpoint__c();
      testEndpoint.Endpoint__c = 'www.google.com';
      testEndpoint.Name = 'MISSING_WEB_USER';
      insert testEndpoint;
    }

    @IsTest
    public static void testFetchMissingUsersSuccess(){
      List<Web_User__c> WebUserDetails;
      StaticResourceCalloutMock mockCallout = new StaticResourceCalloutMock();
      mockCallout.setStaticResource('WebUserApiResponseMockSuccess');

      Test.setMock(HttpCalloutMock.class, mockCallout);
      Test.startTest();
      WebUserDetails = MissingWebUserListCtrl.fetchMissingUsers();
      Test.stopTest();

      System.assertEquals('Testing Test', WebUserDetails[0].Name);
      System.assertEquals('1', WebUserDetails[0].Web_Site_Id__c);
      System.assertEquals('TesterUser', WebUserDetails[0].Username__c);
      System.assertEquals('Test@Testing.biz', WebUserDetails[0].Email__c);
      System.assertEquals('Test Company', WebUserDetails[0].Company__c);
    }

    @IsTest
    public static void testFetchMissingUsersFail(){
      Web_User_Endpoint__c incorrectEndpoint = Web_User_Endpoint__c.getInstance('MISSING_WEB_USER');
      incorrectEndpoint.Name = 'VERY_INCORRECT_ENDPOINT_NAME';
      update incorrectEndpoint;

      String exceptionMessage;

      StaticResourceCalloutMock mockCallout = new StaticResourceCalloutMock();
      mockCallout.setStaticResource('WebUserApiResponseMockSuccess');

      Test.setMock(HttpCalloutMock.class, mockCallout);
      Test.startTest();
      try {
        MissingWebUserListCtrl.fetchMissingUsers();
      } catch (Exception error) {
        exceptionMessage = error.getMessage();
      }
      Test.stopTest();

      System.assert(exceptionMessage != null);
    }

    @IsTest
    public static void testImportMissingWebUsersSuccess(){
      List<Web_User__c> webUsersToInsert = new List<Web_User__c>();
      List<Web_User__c> failedWebUsers;
      webUsersToInsert.add(new Web_User__c(Name = 'TestSuccess', Email__c='Test@Testing.com', Company__c = 'Test company', Web_Site_Id__c = '1'));
      webUsersToInsert.add(new Web_User__c(Name = 'TestDuplicate1', Email__c='Test@Testing.com', Company__c = 'Test company', Web_Site_Id__c = '2'));
      webUsersToInsert.add(new Web_User__c(Name = 'TestDuplicate2', Email__c='Test@Testing.com', Company__c = 'Test Company', Web_Site_Id__c = '2'));

      Test.startTest();
      failedWebUsers = MissingWebUserListCtrl.importMissingWebUsers(webUsersToInsert);
      Test.stopTest();

      System.assertEquals(1, failedWebUsers.size());
    }

    @IsTest
    public static void testImportMissingWebUsersFail(){

    }
}
