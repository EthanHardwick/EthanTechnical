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
    public static void testFetchMissingUsers(){
      List<MissingWebUserListCtrl.WebUserDetailsWrapper> WebUserDetails;
      StaticResourceCalloutMock mockCallout = new StaticResourceCalloutMock();
      mockCallout.setStaticResource('WebUserApiResponseMockSuccess');

      Test.setMock(HttpCalloutMock.class, mockCallout);
      Test.startTest();
      WebUserDetails = MissingWebUserListCtrl.fetchMissingUsers();
      Test.stopTest();

      //make test data annon
      System.assertEquals('Leanne Graham', WebUserDetails[0].name);
      System.assertEquals('1', WebUserDetails[0].id);
      System.assertEquals('Bret', WebUserDetails[0].username);
      System.assertEquals('Sincere@april.biz', WebUserDetails[0].email);
      System.assertEquals('Romaguera-Crona', WebUserDetails[0].companyName);
    }
}
