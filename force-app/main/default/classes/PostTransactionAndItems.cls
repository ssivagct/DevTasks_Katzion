/**
 * Post the Transactions and Items details to the server (Asynchronous)
 * 
 * @author  Sivakumar Sengodan,
 * @since   10 Sep 2020 
 */

public class PostTransactionAndItems{

//Send the Transaction Items records to the 3rd party
@future(callout=true)
public static void postTransactionItems(Id transactionId, Set<id> transactionItemIds){
try{
system.debug('Transaction ITEM IDs' +transactionItemIds);
//Get the JSON string(Transaction) in a payload format
GenerateJSONStringClass trans=new GenerateJSONStringClass();
//Get the JSON string(Transaction Items) in a payload format
String finalJSStringTransactionItem=trans.getTransactionItemsJSON(transactionItemIds);


//Set HTTPRequest Method
  HttpRequest firstReq = new HttpRequest();
  firstReq .setMethod('POST');
  firstReq .setHeader('Accept-Encoding', 'gzip,deflate');
  firstReq .setHeader('content-type', 'application/json');
  firstReq .setHeader('Content-Length', String.valueOf(finalJSStringTransactionItem.length()));
  firstReq .setEndpoint('https://th-apex-http-callout.herokuapp.com/animals');

//Setting body
  System.debug('Input Request:' + finalJSStringTransactionItem);
  firstReq .setBody(finalJSStringTransactionItem);

//Execute web service call here     
  Http http1 = new Http();
  HTTPResponse firstRes = http1.send(firstReq);

//Helpful debug messages
  System.debug(firstRes.toString());
  System.debug('STATUS:' + firstRes.getStatus());
  System.debug('STATUS_CODE:' + firstRes.getStatusCode());
  String responseJSON = firstRes.getBody();
  System.debug('responseXML:' + responseJSON);
  system.debug(+transactionId);
  
//check the response code
 if (firstRes.getStatusCode() == 201) {
 
 String finalJSStringTransaction=trans.getTransactionJSON(transactionId);
//Call the post transaction method to post the transaction
 postTransaction(transactionId, finalJSStringTransaction);
                 
        } else {
            System.debug(firstRes.getBody());
        }
        }catch(Exception err){
         system.debug('Error occured' +err.getMessage());
         system.debug('Error Type' +err.getTypeName());
        }
      
    }
    
    
//Send the Transaction records to the 3rd party  
public static void postTransaction(Id transactionId, string finalJSStringTransaction){
            
//Set HTTPRequest Method
try{
  HttpRequest secondReq= new HttpRequest();
  secondReq.setMethod('POST');
  secondReq.setHeader('Accept-Encoding', 'gzip,deflate');
  secondReq.setHeader('content-type', 'application/json');
  secondReq.setHeader('Content-Length', String.valueOf(finalJSStringTransaction.length()));
  secondReq.setEndpoint('https://th-apex-http-callout.herokuapp.com/animals');

//Setting body
  System.debug('Input Request:' + finalJSStringTransaction);
  secondReq.setBody(finalJSStringTransaction);

//Execute web service call here     
  Http http2 = new Http();
  HTTPResponse secondRes = http2.send(secondReq);

//Helpful debug messages
  System.debug(secondRes.toString());
  System.debug('STATUS:' + secondRes.getStatus());
  System.debug('STATUS_CODE:' + secondRes.getStatusCode());
  String secondResponseJSON = secondRes.getBody();
  System.debug('responseJSON:' + secondResponseJSON);
  system.debug(+transactionId);
  }catch(Exception err){
   system.debug('Error occured' +err.getMessage());
   system.debug('Error Type' +err.getTypeName());
  }

}    
    

}