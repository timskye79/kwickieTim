//
//  KwickieServer.m
//  kwickieTim
//
//  Created by Test on 13/03/2016.
//  Copyright © 2016 Tim. All rights reserved.
//

#import "KwickieServer.h"
#import "myURLSession.h"


@implementation KwickieServer

-(void)completeWith:(NSString *)notificationComplete listen:(NSString *)notificationName
{
    NSLog(@"%s",__PRETTY_FUNCTION__);
    
    //Notification name to update GUI with new data
    self.notificationCompleteString = notificationComplete;
    
    //Request data from server when we receive a notification
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(requestServerData:) name:notificationName object:nil];
    
}


-(void) requestServerData:(NSNotification *)notification
{
    NSLog(@"%s",__PRETTY_FUNCTION__);
    
    //URL
    NSMutableString *serverAddress = [NSMutableString stringWithFormat:@"https://bigdev.kwickie.com/api/kwickies/featured"];
    
    //connect
    self.myConnection = [[myURLSession alloc] init];
    
    NSString *methodServerReplied = @"serverReplyReceived_KwickieFeatured";
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(serverReplyReceived:) name:methodServerReplied object:nil];
    
    //Initiate connection to server. Response is received in method specified
    [self.myConnection connectUrl:serverAddress notifyMethodName:methodServerReplied];
    
}

-(void)serverReplyReceived:(NSNotification *)notification  //This notification will be received in the background
{
    NSLog(@"%s",__PRETTY_FUNCTION__);
    
    NSDictionary *notification_dict = [notification userInfo];
    NSData *serverReplyData = [notification_dict objectForKey:@"NSData"];
   // NSError *serverError = [notification_dict objectForKey:@"NSError"];
    
   // NSString *rawServerReply = [[NSString alloc] initWithData:serverReplyData encoding:NSUTF8StringEncoding];
   // NSLog(@"rawServerReply = [%@]", rawServerReply);

   // deal with error. Retry, cancel, delay, etc...
   // NSLog(@"serverReplyError = [%@]", serverError.debugDescription);
    

    
    
    
    //Send notification that we are complete:
    NSMutableDictionary *dataDict = [[NSMutableDictionary alloc] init];
    id id_data = serverReplyData;
    [dataDict setObject:id_data forKey:@"NSData"];
    [[NSNotificationCenter defaultCenter] postNotificationName:self.notificationCompleteString object:self userInfo:dataDict];
    
}

-(void) dealloc
{
    NSLog(@"%s",__PRETTY_FUNCTION__);
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
