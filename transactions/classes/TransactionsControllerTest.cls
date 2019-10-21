@isTest
global with sharing class TransactionsControllerTest {
    @isTest
    public static void saveTransactionTest() {        
        Transaction__c tranc = new Transaction__c(Name = 'Testing 1', Amount__c = 0.3, Date__c = Date.valueOf('2018-12-31'));
        System.assertEquals(true, TransactionsController.saveTransaction(tranc));        
    }	
    @isTest
    public static void saveNullTransactionTest() {        
        Transaction__c tranc = null;
        System.assertEquals(false, TransactionsController.saveTransaction(tranc)); 
    }    
    @isTest
    public static void saveTransactionWithEmptyAmmountTest() {        
        Transaction__c tranc = new Transaction__c(Name = 'Testing 1', Amount__c = 0.0, Date__c = Date.valueOf('2018-12-31'));
        System.assertEquals(false, TransactionsController.saveTransaction(tranc)); 
    }    
    @isTest
    public static void getTransactionTest() {  
        List<sObject> emptyList = new List<sObject>();
        System.assertEquals(emptyList, TransactionsController.getTransactions()); 
    }    
}