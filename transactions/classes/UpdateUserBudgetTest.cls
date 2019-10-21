@isTest
public class UpdateUserBudgetTest {
	@isTest
    public static void updateUserBudgeAfterInsertTransactionTest() {
        User testUser = [SELECT id, Username, Budget__c FROM User WHERE Username = 'ruslan.chubarev@gmail.com'];
        Double currentBudget = testUser.Budget__c;
        Transaction__c trans = new Transaction__c (Name = 'Test for trigger', Amount__c = 0.1, Date__c = Date.valueOf('2019-10-15'), OwnerId = testUser.Id);
        insert trans;
        User newTestUser = [SELECT id, Username, Budget__c FROM User WHERE Username = 'ruslan.chubarev@gmail.com'];
        System.assertEquals(currentBudget + trans.Amount__c, newTestUser.Budget__c);
    }
    @isTest
    public static void updateUserBudgeAfterDeleteTransactionTest() {
        User testUser = [SELECT id, Username, Budget__c FROM User WHERE Username = 'ruslan.chubarev@gmail.com'];
        Double currentBudget = testUser.Budget__c;
        Transaction__c trans = new Transaction__c (Name = 'Test for delete trigger', Amount__c = 0.2, Date__c = Date.valueOf('2019-10-15'),OwnerId = testUser.Id);
        insert trans;
        delete trans;
        User newTestUser = [SELECT id, Username, Budget__c FROM User WHERE Username = 'ruslan.chubarev@gmail.com'];
        System.assertEquals(currentBudget, newTestUser.Budget__c);
    }
    @isTest
    public static void updateUserBudgeAfterEditTransactionTest() {
        User testUser = [SELECT id, Username, Budget__c FROM User WHERE Username = 'ruslan.chubarev@gmail.com'];
        Double currentBudget = testUser.Budget__c;
        Transaction__c transForEdit = new Transaction__c (Name = 'Test for edit trigger', Amount__c = 0.2, Date__c = Date.valueOf('2019-10-15'),OwnerId = testUser.Id);
        insert transForEdit;
        Transaction__c trans = [SELECT id, Name, Amount__c, Date__c FROM Transaction__c WHERE Name = 'Test for edit trigger'];
        Double oldAmount = trans.Amount__c;
        trans.Amount__c = 0.24;
        update trans;
        User newTestUser = [SELECT id, Username, Budget__c FROM User WHERE Username = 'ruslan.chubarev@gmail.com'];
        System.assertEquals(currentBudget  + trans.Amount__c, newTestUser.Budget__c);
    }
}