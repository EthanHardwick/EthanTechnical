public with sharing class WebUserCalloutClient {

    private Web_User_Endpoint__c webUserEndpoint;

    public WebUserCalloutClient(String webUserEndpoint){
      this.webUserEndpoint = Web_User_Endpoint__c.getInstance(webUserEndpoint);
    }

    public HttpResponse makeCallout(String method){
      String endpoint = this.webUserEndpoint.Endpoint__c;
      Http h = new Http();
      HttpRequest request = new HttpRequest();
      request.setEndpoint(endpoint);
      request.setMethod(method);
      HttpResponse response = h.send(request);
      return response;
    }
}
