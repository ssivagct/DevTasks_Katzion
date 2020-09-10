/**
 * HttpCalloutMock which is used to test the future methods
 * 
 * @author  Sivakumar Sengodan,
 * @since   10 Sep 2020 
 */
 //global test class which implements HttpCalloutMock and its used in Test class to mock the response
 global class TransactionsHttpCalloutMock implements HttpCalloutMock{

    global HTTPResponse respond(HTTPRequest request) {
        // Create a fake response
        HttpResponse response = new HttpResponse();
        response.setHeader('Content-Type', 'application/json');
        response.setBody('{"animals": ["majestic badger", "fluffy bunny", "scary bear", "chicken", "mighty moose"]}');
        response.setStatusCode(201);
        return response; 
    }

}