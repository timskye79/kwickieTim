//
//  KwickieJSON.m
//  kwickieTim
//
//  Created by Test on 13/03/2016.
//  Copyright © 2016 Tim. All rights reserved.
//

#import "KwickieJSON.h"

@implementation KwickieJSON


- (NSError *) convertDataToJASON:(NSData *)data successNotification:(NSString *)notificationName
{
    NSLog(@"%s",__PRETTY_FUNCTION__);
    
    NSError *jsonError;
    NSDictionary *dictJSON = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&jsonError];
    if (!jsonError)
    {
        
        [[NSNotificationCenter defaultCenter] postNotificationName:notificationName object:self userInfo:dictJSON];
        
    }
    else
    {
        NSLog(@"[convertDataToJASON] jsonError = [%@]", jsonError);
        return jsonError;
    }
    
    return nil;
}

@end
