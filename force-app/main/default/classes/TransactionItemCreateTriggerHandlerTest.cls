/**
 * Test class Transaction Item/Transaction POST logic
 * 
 * @author  Sivakumar Sengodan,
 * @since   10 Sep 2020 
 */
@IsTest
private class TransactionItemCreateTriggerHandlerTest{


private static testMethod void transactionItemCreateTest(){

List<Transaction__c> transactionsTest=new List<Transaction__c>();
List<TransactionItem__c> transactionItemsTest=new List<TransactionItem__c>();
Id transactionIdTest;
Set<Id> transactionItemIdsTest=new Set<Id>();

Transaction__c trans1=new Transaction__c(Name='Test_Transaction_1', Total_Cost__c=20, Total_Discount__c=40, Transaction_Count__c=3);

Insert trans1;
transactionIdTest=trans1.id;

TransactionItem__c transItem1=new TransactionItem__c(Name='Test_Trans_Item1',Item_Cost__c=30, Transaction__c=trans1.id);
TransactionItem__c transItem2=new TransactionItem__c(Name='Test_Trans_Item2',Item_Cost__c=40, Transaction__c=trans1.id);
TransactionItem__c transItem3=new TransactionItem__c(Name='Test_Trans_Item3',Item_Cost__c=10, Transaction__c=trans1.id);

transactionItemsTest.add(transItem1);
transactionItemsTest.add(transItem2);
transactionItemsTest.add(transItem3);

//Start test
Test.startTest();

Insert transactionItemsTest;
system.debug('Transac: ' +transactionItemsTest);

for(TransactionItem__c transItemTest: transactionItemsTest){
transactionItemIdsTest.add(transItemTest.id);
}
system.debug('Transac Items: ' +transactionItemIdsTest);
//Set a mock response to test
Test.setMock(HttpCalloutMock.class, new TransactionsHttpCalloutMock());
PostTransactionAndItems.postTransactionItems(transactionIdTest, transactionItemIdsTest);
//Stop test
Test.stopTest();


}

}