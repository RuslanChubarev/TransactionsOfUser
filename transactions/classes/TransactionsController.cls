public with sharing class TransactionsController {        
    @AuraEnabled
    public static boolean saveTransaction(Transaction__c myTransaction) {        
		try{
            System.debug('CreateTransactionRecord::createRecord::transaction'+myTransaction);            
            if(myTransaction != null && myTransaction.Amount__c != 0) {
                insert myTransaction;
                return true;
            } else {
                return false;
            }           
        } catch (Exception ex){
        	System.debug('Exception:'+ex);     
        }
        return false;
    }
    
    @AuraEnabled
    public static List<Transaction__c> getTransactions(Transaction__c myTransaction) {
        id userId =  UserInfo.getUserId();
        return [SELECT Id, Name, Amount__c, Date__c FROM Transaction__c WHERE OwnerId = :userId ORDER BY Date__c DESC];		
    }
}   