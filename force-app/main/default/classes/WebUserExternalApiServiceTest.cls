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
    System.assertEquals('Testing Test', webUsers[0].name);
    System.assertEquals('TesterUser', webUsers[0].username);
    System.assertEquals('Test@Testing.biz', webUsers[0].email);
    System.assertEquals('01234567898', webUsers[0].phone);
    System.assertEquals('TestOrg', webUsers[0].website);
    System.assertEquals('Test Street', webUsers[0].address.street);
    System.assertEquals('Apt. 556', webUsers[0].address.suite);
    System.assertEquals('Test City', webUsers[0].address.city);
    System.assertEquals('92998-3874', webUsers[0].address.zipcode);
    System.assertEquals('-37.3159', webUsers[0].address.geo.lat);
    System.assertEquals('81.1496', webUsers[0].address.geo.lng);
    System.assertEquals('Test Company', webUsers[0].company.name);
    System.assertEquals('We do Testing', webUsers[0].company.catchPhrase);
    System.assertEquals('Testing Tests', webUsers[0].company.bs);
  }

   @IsTest
  public static void testDoCalloutFail(){
    Web_User_Endpoint__c incorrectEndpoint = Web_User_Endpoint__c.getInstance('MISSING_WEB_USER');
    incorrectEndpoint.Name = 'VERY_INCORRECT_ENDPOINT_NAME';
    update incorrectEndpoint;

    String exceptionMessage;

    StaticResourceCalloutMock mockCallout = new StaticResourceCalloutMock();
    mockCallout.setStaticResource('WebUserApiResponseMockSuccess');
    Test.setMock(HttpCalloutMock.class, mockCallout);

    Test.startTest();
    try{
      new WebUserExternalApiService().doCallout();
    } catch(Exception error) {
      exceptionMessage = error.getMessage();
    }
    Test.stopTest();
    System.assert(exceptionMessage != null);
  }
}
