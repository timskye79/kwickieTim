//
//  KwickieController.h
//  kwickieTim
//
//  Created by Test on 13/03/2016.
//  Copyright © 2016 Tim. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "KwickieServer.h"


@interface KwickieController : NSObject

@property (strong, nonatomic) KwickieServer *myKwickieServer;


- (void) start;

@end
