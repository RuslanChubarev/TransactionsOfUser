@RestResource(urlMapping='/Users/*')
global with sharing class UserAndTransactionManager {
    @HttpPost
    global static ID createUser(String username,
                                List<Transaction__c> transactions) {
        User user = [SELECT id, LastName, Alias, Username FROM User WHERE Username = :username];
        
        for (Transaction__c trans : transactions) {
            trans.OwnerId = user.Id;
        } 
                                    
        insert transactions;
        return user.Id;
    }
}