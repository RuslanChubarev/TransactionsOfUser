public class UserController {
	@AuraEnabled
    public static User getUser() {
        id userId =  UserInfo.getUserId();
        return [select Id, Name, Budget__c, Username from User WHERE id=:userId Limit 1];
    }
}