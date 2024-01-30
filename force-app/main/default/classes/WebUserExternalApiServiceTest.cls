@IsTest
public with sharing class WebUserExternalApiServiceTest {

  @TestSetup
  static void setupData(){
    Web_User_Endpoint__c testEndpoint = new Web_User_Endpoint__c();
    testEndpoint.Endpoint__c = 'www.google.com';
    testEndpoint.Name = 'MISSING_WEB_USER';
    insert testEndpoint;
  }

  @IsTest
  public static void testDoCalloutSuccess(){
    List<WebUserExternalApiService.WebUserResponseWrapper> webUsers;

    StaticResourceCalloutMock mockCallout = new StaticResourceCalloutMock();
    mockCallout.setStaticResource('WebUserApiResponseMockSuccess');

    Test.setMock(HttpCalloutMock.class, mockCallout);
    Test.startTest();
    webUsers = new WebUserExternalApiService().doCallout();
    Test.stopTest();

    System.assert(webUsers != null);
    System.assertEquals('1', webUsers[0].id);
  }
}
