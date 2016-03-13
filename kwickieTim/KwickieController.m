//
//  KwickieController.m
//  kwickieTim
//
//  Created by Test on 13/03/2016.
//  Copyright © 2016 Tim. All rights reserved.
//

#import "KwickieController.h"
#import "KwickieServer.h"
#import "KwickieJSON.h"

@implementation KwickieController

- (void) start
{
    NSLog(@"%s",__PRETTY_FUNCTION__);
    
    NSString *methodDataReceived = @"getDataFromKwickieServer_COMPLETE";
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(getDataFromKwickieServer_COMPLETE:) name:methodDataReceived object:nil];
    self.myKwickieServer = [[KwickieServer alloc] init];
    [self.myKwickieServer completeWith:methodDataReceived listen:@"getDataFromKwickieServer"];
    //Get data from server
    [[NSNotificationCenter defaultCenter] postNotificationName:@"getDataFromKwickieServer" object:self userInfo:nil];
    
    
}

-(void)getDataFromKwickieServer_COMPLETE:(NSNotification *)notification
{
    NSLog(@"%s",__PRETTY_FUNCTION__);
    
    NSDictionary *notification_dict = [notification userInfo];
    NSData *serverReplyData = [notification_dict objectForKey:@"NSData"];

    
    NSString *methodJSONsuccess = @"processJSON";
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(processJSON:) name:methodJSONsuccess object:nil];
    KwickieJSON *myKwickieJSON = [KwickieJSON alloc];
    NSError *errorJSON = [myKwickieJSON convertDataToJASON:serverReplyData successNotification:methodJSONsuccess];
    
    if (errorJSON)
    {
        NSLog(@"JSON conversion error = [%@]", errorJSON.debugDescription);
    }
    else
    {
       // NSLog(@"JSON conversion success = [%@]", errorJSON.debugDescription);
    }
    

    
}

-(void)processJSON:(NSNotification *)notification
{
    NSLog(@"%s",__PRETTY_FUNCTION__);
    
    NSDictionary *dictJSON = [notification userInfo];

   // NSLog(@"JSON = [%@]", dictJSON.debugDescription);

    [[NSNotificationCenter defaultCenter] postNotificationName:@"newTableViewData" object:self userInfo:dictJSON];

    
    
}




@end
