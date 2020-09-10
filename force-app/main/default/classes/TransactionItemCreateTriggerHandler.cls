/**
 * Handles Transaction Item creation
 * 
 * @author  Sivakumar Sengodan,
 * @since   10 Sep 2020 
 */
public class TransactionItemCreateTriggerHandler{

//To check the eligibility of transaction list items sent to the 3rd party web service 
public void checkTransactionItemListPostEligibility(List<TransactionItem__c> transcItems){

List<TransactionItem__c> transactionItems=new List<TransactionItem__c>();
List<Transaction__c> transactions=new List<Transaction__c>();
Set<Id> transactionItemIds=new Set<Id>();
Set<Id> transactionIds=new Set<Id>();
Id transactionId;

List<Transaction__c> transactionswithItem=new List<Transaction__c>();
List<TransactionItem__c> allTransactionItems=new List<TransactionItem__c>();

//Get the transactions, ids and related records
try{
for(TransactionItem__c transitem: [select id, Name, Item_Cost__c, Transaction__r.id, Transaction__r.Total_Cost__c, Transaction__r.Total_Discount__c, Transaction__r.Transaction_Count__c from TransactionItem__c where id in:transcItems]){
    
    transactionItems.add(transitem);
    transactions.add(transitem.Transaction__r);
    transactionIds.add(transitem.Transaction__r.id);
    
}
system.debug('Transactions' +transactions);
system.debug('Transaction Items' +transactionItems);
system.debug('Transaction Ids' +transactionIds);

//Get the transaction and transaction items details
transactionswithItem=[SELECT Id, (SELECT Id, Name, Item_Cost__c from TransactionItem__r) from Transaction__c where Id in :transactionIds];
system.debug('Transaction with Items' +transactionswithItem);

for(Transaction__c transact:transactionswithItem){
for(TransactionItem__c ti:transact.TransactionItem__r){
allTransactionItems.add(ti);
}

}

system.debug('Transaction ALL Items' +allTransactionItems);

//Iterate each transaction from list of changed transactions and check the eligibility 
for(Transaction__c trans: transactions){

//Get the number of related transaction items against each transaction
    Integer countOfChildRecords=[SELECT count() from TransactionItem__c where Transaction__r.id=:trans.id];
    system.debug('Count' +countOfChildRecords);
 //Check if number of related transaction items match with transaction count value on transaction
    if(countOfChildRecords == trans.Transaction_Count__c.intValue()){
        
        for(TransactionItem__c tansItem: allTransactionItems){
//Get all the transaction ids needs to be sent      
            transactionItemIds.add(tansItem.Id);
            
        }
//Make a call to the future method to send the data
        if(trans.id!=null && transactionItemIds.size()>0)
        {
       PostTransactionAndItems.postTransactionItems(trans.id, transactionItemIds);
        }
    }
    
    } 
    }catch(Exception err){
     system.debug('Error occured' +err.getMessage());
     system.debug('Error Type' +err.getTypeName());
    }
}
    
}