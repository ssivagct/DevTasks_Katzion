/**
 * JSON string generator
 * 
 * @author  Sivakumar Sengodan,
 * @since   10 Sep 2020 
 */
public class GenerateJSONStringClass{

//Generate JSON string for the Transaction
public string getTransactionJSON(Id transactionId){
String finalJSStringTransaction;

//Get the list of transactions
List<Transaction__c> tansactions=[SELECT Id, Total_Cost__c, Total_Discount__c, Transaction_Count__c, CreatedDate FROM Transaction__c where Id=:transactionId];
System.JSONGenerator js=JSON.createGenerator(true);

if(tansactions!=null && tansactions.size()>0){

for(Transaction__c trans:tansactions){
//Construct JSON
js.writeStartObject();
js.writeFieldName('keys');
js.writeStartObject();
js.writeStringField('TransactionID',trans.Id);
js.writeEndObject();

js.writeFieldName('values');
js.writeStartObject();
js.writeStringField('TotalCost',String.valueOf(trans.Total_Cost__c));
js.writeStringField('TotalDiscount',String.valueOf(trans.Total_Discount__c));
js.writeStringField('TransactionDate',String.valueOf(trans.CreatedDate.format('yyyy-MM-dd')));
js.writeStringField('TotalCount',String.valueOf(Integer.ValueOf(trans.Transaction_Count__c)));
js.writeEndObject();

js.writeEndObject();

}
    
}

//convert to String format
finalJSStringTransaction=js.getAsString();

system.debug('Result: ' +finalJSStringTransaction);

//return the result
return finalJSStringTransaction;

}


//Generate JSON string for the Transaction Items
public string getTransactionItemsJSON(Set<id> transactionItemIds){

system.debug('Transaction ITEM IDs' +transactionItemIds);
String finalJSStringTransactionItems;

//Get the list of transactions
List<TransactionItem__c> tansItemList=[SELECT Id, Name, Item_Cost__c from TransactionItem__c where Id in :transactionItemIds];
System.JSONGenerator js=JSON.createGenerator(true);

if(tansItemList!=null && tansItemList.size()>0){

js.writeStartarray();

for(TransactionItem__c trans:tansItemList){
//Construct JSON
js.writeStartObject();
js.writeFieldName('keys');
js.writeStartObject();
js.writeStringField('TransactionItemID',trans.Id);
js.writeEndObject();

js.writeFieldName('values');
js.writeStartObject();
if(trans.Name==null)
{
trans.Name='EmptyString';
}
js.writeStringField('ItemCost',trans.Name);

if(trans.Item_Cost__c==null){
trans.Item_Cost__c=0;
}
js.writeStringField('ItemName',String.valueOf(trans.Item_Cost__c));
js.writeEndObject();

js.writeEndObject();

}
    
js.writeEndArray();
}


//convert to String format
finalJSStringTransactionItems=js.getAsString();

system.debug('Result: ' +finalJSStringTransactionItems);

//return the result
return finalJSStringTransactionItems;

}

}