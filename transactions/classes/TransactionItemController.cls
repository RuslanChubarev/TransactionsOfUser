public class TransactionItemController {
    @AuraEnabled
    public static void deleteTransaction(Transaction__c myTransaction) {
        try {
            System.debug('deleteTransactionRecord::deleteTransaction::transaction'+myTransaction);
            
            if(myTransaction != null) {
                delete myTransaction;
            }            
        } catch (Exception ex) {
        	System.debug('Exception '+ex);    
        }
    }
}