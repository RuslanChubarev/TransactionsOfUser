@isTest
global class UserAndTransactionManagerTest {    
    @isTest static void testCreateUser() {
        User testUser = [SELECT Id FROM User WHERE Username = 'ruslan.chubarev@gmail.com'];
        Transaction__c trans = new Transaction__c(
            Name='Test record 123',
            Amount__c= 0.0,
            Date__c = Date.valueOf('2018-12-31'),
        	OwnerId = testUser.Id);
        List<Transaction__c> transactions = new List<Transaction__c>();
        transactions.add(trans);
        ID userId = UserAndTransactionManager.createUser(
            'ruslan.chubarev@gmail.com', transactions);
        System.assert(userId != null);
        Transaction__c trans1 = [SELECT Id,Name, Amount__c, Date__c FROM Transaction__c WHERE Id=:trans.Id];
        System.assert(trans1 != null);
        System.assertEquals(trans1.Name, 'Test record 123');
    }    
}