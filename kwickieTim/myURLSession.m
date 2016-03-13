//
//  myURLSession.m
//  kwickieTim
//
//  Created by Test on 13/03/2016.
//  Copyright © 2016 Tim. All rights reserved.
//

#import "myURLSession.h"


@implementation myURLSession



-(void)connectUrl:(NSString *)serverAddress notifyMethodName:(NSString *)notifyMethodName
{
    NSLog(@"%s",__PRETTY_FUNCTION__);
    
    //Notification name requested:
    self.notifyMethodName = notifyMethodName;
    
    //server URL
    self.URL = serverAddress;
    
    //We pass all data received from the server via a dictionary in a notification
    self.myDictionary = [[NSMutableDictionary alloc] init];
    
    //all data received from the server will be stored here:
    self.receivedData = [[NSMutableData alloc] init];
    
    
    NSURLSessionConfiguration *sessionConfig = [NSURLSessionConfiguration defaultSessionConfiguration];
    self.connection = [NSURLSession sessionWithConfiguration:sessionConfig delegate:self delegateQueue:nil];
    
    //URL
    NSURL *serverAddressURL = [[NSURL alloc]initWithString:[serverAddress stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]]];
    
    //Create a new connection task:
    NSURLSessionDataTask *dataTask = [self.connection dataTaskWithURL:serverAddressURL];
    
    //start the connection:
    [dataTask resume];
    
}

-(void)URLSession:(NSURLSession *)session dataTask:(NSURLSessionDataTask *)dataTask didReceiveData:(NSData *)data
{
    NSLog(@"%s",__PRETTY_FUNCTION__);
    
    [self.receivedData appendData:data];
    
}

-(void)URLSession:(NSURLSession *)session task:(NSURLSessionTask *)task didCompleteWithError:(NSError *)error
{
    NSLog(@"%s didFailWithError: [%@]",__PRETTY_FUNCTION__, error.debugDescription);
 
    id id_serverData = self.receivedData;
    [self.myDictionary setObject:id_serverData forKey:@"NSData"];
    id id_serverURL = self.URL;
    [self.myDictionary setObject:id_serverURL forKey:@"URL"];
    
    if (!error)
    {
        error = [NSError errorWithDomain:@"NSCocoaErrorDomain" code:0 userInfo:nil];
    }
    
    id id_error = error;
    [self.myDictionary setObject:id_error forKey:@"NSError"];
    

    [[NSNotificationCenter defaultCenter] postNotificationName:self.notifyMethodName object:self userInfo:self.myDictionary];
    
    
}


-(void) dealloc
{
    NSLog(@"%s [%@]",__PRETTY_FUNCTION__, self.notifyMethodName);
    
}


@end
