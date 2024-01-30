/**
 * Created by jesus.cantero on 13/05/2021.
 */

public with sharing class MissingWebUserListCtrl {

  @AuraEnabled(cacheable=true)
  public static List<WebUsersWrapper> fetchMissingUsers(){
    List<WebUsersWrapper> webUserDetails = new List<WebUsersWrapper>();
    try {
      for (WebUserExternalApiService.WebUserResponseWrapper webUser : new WebUserExternalApiService().doCallout()) {
        webUserDetails.add(new WebUsersWrapper(webUser));
      }
    } catch (Exception error) {
      AuraHandledException handledException = new AuraHandledException(error.getMessage());
      handledException.setMessage(error.getMessage());
      throw handledException;
    }
    return webUserDetails;
  }

  public class WebUsersWrapper {
    @AuraEnabled
    public String id {get;set;}
    @AuraEnabled
    public String name {get;set;}
    @AuraEnabled
    public String userName {get;set;}
    @AuraEnabled
    public String email {get;set;}
    @AuraEnabled
    public String companyName {get;set;}

    public WebUsersWrapper(WebUserExternalApiService.WebUserResponseWrapper webUser){
      this.id = webUser.id;
      this.name = webUser.name;
      this.userName = webUser.username;
      this.email = webUser.email;
      this.companyName = webUser.company.name;
    }
  }
}
