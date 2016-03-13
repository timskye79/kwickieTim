//
//  RootViewController.h
//  kwickieTim
//
//  Created by Test on 13/03/2016.
//  Copyright © 2016 Tim. All rights reserved.
//
#import <UIKit/UIKit.h>
#import "KwickieViewController.h"

@interface RootViewController : UIViewController

@property (strong, nonatomic) UIView *statusBarView;
@property (assign, nonatomic) CGRect statusBarFrame;
@property (strong, nonatomic) UIView *fullScreenView;

@property (strong, nonatomic) KwickieViewController *kwickieVC;



enum
{
    STATUS_BAR_HEIGHT = 20,
    
};

@end

