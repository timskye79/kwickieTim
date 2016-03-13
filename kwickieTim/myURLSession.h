//
//  myURLSession.h
//  kwickieTim
//
//  Created by Test on 13/03/2016.
//  Copyright © 2016 Tim. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface myURLSession : NSObject <NSURLSessionDataDelegate>

@property (retain, nonatomic) NSURLSession *connection;
@property (retain, nonatomic) NSMutableData *receivedData;

@property (strong, nonatomic) NSString *notifyMethodName;
@property (strong, nonatomic) NSString *URL;

@property (nonatomic, strong) NSMutableDictionary *myDictionary;





-(void)connectUrl:(NSString *)serverAddress notifyMethodName:(NSString *)notifyMethodName;



@end
