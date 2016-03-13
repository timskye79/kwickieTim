//
//  KwickieServer.h
//  kwickieTim
//
//  Created by Test on 13/03/2016.
//  Copyright © 2016 Tim. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "myURLSession.h"

@interface KwickieServer : NSObject

@property (strong, nonatomic) myURLSession *myConnection;
@property (strong, nonatomic) NSString *notificationCompleteString;

-(void)completeWith:(NSString *)notificationComplete listen:(NSString *)notificationListen;


@end
