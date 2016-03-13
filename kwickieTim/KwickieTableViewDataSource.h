//
//  KwickieTableViewDataSource.h
//  kwickieTim
//
//  Created by Test on 13/03/2016.
//  Copyright © 2016 Tim. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "myURLSession.h"


@interface UITableView (Updating)
- (void) updateData;
@end


@interface KwickieTableViewDataSource : NSObject <UITableViewDataSource, UITableViewDelegate>

@property (strong, atomic) NSDictionary *myLibrary;
@property (strong, atomic) NSMutableDictionary *myLibraryImages;
@property (strong, atomic) NSMutableDictionary *myLibraryVideos;
@property (strong, atomic) myURLSession *myConnection;



- (void) startObserver:(NSString *)notificationsName;


@end
