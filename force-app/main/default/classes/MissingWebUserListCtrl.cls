/**
 * Created by jesus.cantero on 13/05/2021.
 */

public with sharing class MissingWebUserListCtrl {


  @AuraEnabled
  public static List<WebUserDetailsWrapper> fetchMissingUsers(){
    try {

    } catch (Exception error) {
      throw new AuraHandledException(error.getMessage());
    }

    return new List<WebUserDetailsWrapper>();
  }

  public class WebUserDetailsWrapper {
    public String id {get;set;}
    public String name {get;set;}
    public String username {get;set;}
    public String email {get;set;}
    public String companyName {get;set;}
  }
}
