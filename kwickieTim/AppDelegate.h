//
//  AppDelegate.h
//  kwickieTim
//
//  Created by Test on 13/03/2016.
//  Copyright © 2016 Tim. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RootViewController.h"
#import "KwickieController.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (assign, nonatomic) CGRect currentStatusBarFrame;
@property (strong, nonatomic) RootViewController *RootVC;

@property (strong, nonatomic) KwickieController *myKwickieProgramController;

@end

