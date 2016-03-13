//
//  KwickieViewController.h
//  kwickieTim
//
//  Created by Test on 13/03/2016.
//  Copyright © 2016 Tim. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KwickieTableViewDataSource.h"

@interface KwickieViewController : UIViewController

@property (strong, nonatomic) UIView *headingView;
@property (strong, nonatomic) UITableView *kwickieTableView;
@property (strong, nonatomic) KwickieTableViewDataSource *kwickieTableViewDataSource;



@end
