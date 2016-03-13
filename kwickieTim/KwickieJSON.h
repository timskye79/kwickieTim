//
//  KwickieJSON.h
//  kwickieTim
//
//  Created by Test on 13/03/2016.
//  Copyright © 2016 Tim. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface KwickieJSON : NSObject

- (NSError *) convertDataToJASON:(NSData *)data successNotification:(NSString *)notificationName;


@end
