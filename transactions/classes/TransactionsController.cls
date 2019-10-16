public with sharing class TransactionsController {        
    @AuraEnabled
    public static void saveTransaction(Transaction__c myTransaction) {        
		try{
            System.debug('CreateTransactionRecord::createRecord::transaction'+myTransaction);            
            if(myTransaction != null && myTransaction.Amount__c != 0) {
                insert myTransaction;
            }            
        } catch (Exception ex){
        	System.debug('Exception:'+ex);     
        }
    }
    
    @AuraEnabled
    public static List<Transaction__c> getTransactions(Transaction__c myTransaction) {
        return [SELECT Id, Name, Amount__c, Date__c FROM Transaction__c ORDER BY Date__c DESC];		
    }
}