public with sharing class WebUserExternalApiService {
  public static final String MISSING_WEB_USER_ENDPOINT = 'MISSING_WEB_USER';
  public static final String HTTP_METHOD_GET = 'GET';

  public List<WebUserResponseWrapper> doCallout(){
    HttpResponse response;
    try {
      WebUserCalloutClient client = new WebUserCalloutClient(MISSING_WEB_USER_ENDPOINT);
      response = client.makeCallout(HTTP_METHOD_GET);
    } catch (Exception error) {
      throw new WebUserApiException(error.getMessage());
    }
    return (List<WebUserResponseWrapper>)JSON.deserialize(response.getBody(), List<WebUserResponseWrapper>.class);
  }

  public class WebUserResponseWrapper {
    public String id {get;set;}
    public String name {get;set;}
    public String username {get;set;}
    public String email {get;set;}
    public Address address {get;set;}
    public String phone {get;set;}
    public String website {get;set;}
    public Company company {get;set;}
  }

  public class Address {
    public String street {get;set;}
    public String suite {get;set;}
    public String city {get;set;}
    public String zipcode {get;set;}
    public Geo geo {get;set;}
  }

  public class Geo {
    public String lat {get;set;}
    public String lng {get;set;}
  }

  public class Company {
    public String name {get;set;}
    public String catchPhrase {get;set;}
    public String bs {get;set;}
  }

  public class WebUserApiException extends Exception {}
}
