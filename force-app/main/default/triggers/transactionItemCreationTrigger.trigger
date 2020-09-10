/**
 * Handles the order of execution for the TransactionItem object trigger.
 * 
 * @author  Sivakumar Sengodan,
 * @since   10 Sep 2020 
 */

trigger transactionItemCreationTrigger on TransactionItem__c(after insert) {

/* After Insert */
if(Trigger.new.size()>0 && Trigger.isInsert && Trigger.isAfter){

try{
  transactionItemCreateTriggerHandler newItem= new transactionItemCreateTriggerHandler();
  newItem.checkTransactionItemListPostEligibility(Trigger.new);
  }catch(Exception err){
  system.debug('Error occured' +err.getMessage());
  system.debug('Error Type' +err.getTypeName());
  
  }
 }
 

}