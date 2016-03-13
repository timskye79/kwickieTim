//
//  RootViewController.m
//  kwickieTim
//
//  Created by Test on 13/03/2016.
//  Copyright © 2016 Tim. All rights reserved.
//

#import "RootViewController.h"
#import "KwickieViewController.h"


@interface RootViewController ()

@end

@implementation RootViewController


- (BOOL)prefersStatusBarHidden
{
    return NO;
}


- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

- (void)viewWillTransitionToSize:(CGSize)size withTransitionCoordinator:(id<UIViewControllerTransitionCoordinator>)coordinator
{
     [super viewWillTransitionToSize:size withTransitionCoordinator:coordinator];
    
        //do nothing before rotation
    
    [coordinator animateAlongsideTransition:^(id<UIViewControllerTransitionCoordinatorContext> context) {
        
        // Animations during rotation
        [self adjustFullScreenView];
        
    } completion:^(id<UIViewControllerTransitionCoordinatorContext> context) {
        
            //do nothing afer rotation
        
        
    }];
}

- (void)adjustFullScreenView
{
    CGRect screenBounds = [UIScreen mainScreen].bounds;
    self.fullScreenView.frame = CGRectMake(0, 0+STATUS_BAR_HEIGHT, screenBounds.size.width, screenBounds.size.height-self.statusBarFrame.size.height);
    
}

- (void)setupObservers
{
    //NSLog(@"%s",__PRETTY_FUNCTION__);
    
    //---[ Received BEFORE statusbar frame change ]---
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(statusBarFrameChanged:)
                                                 name:@"statusBarFrameChanged"
                                               object:[[UIApplication sharedApplication] delegate]];
    
    //---[ Received AFTER statusbar frame change ]---
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(statusBarFrameChangedFullScreenView:)
                                                 name:@"statusBarFrameChangedFullScreenView"
                                               object:[[UIApplication sharedApplication] delegate]];
    
    
    
}

//---[ Received BEFORE statusbar frame change ]---
//notification from AppDelegate.m - (void) application:(UIApplication *)application willChangeStatusBarFrame:(CGRect)newStatusBarFrame
- (void)statusBarFrameChanged:(NSNotification*)notification
{
    //NSLog(@"%s",__PRETTY_FUNCTION__);
    self.statusBarFrame = [[notification.userInfo objectForKey:@"currentStatusBarFrame"] CGRectValue];
    
    self.statusBarView.frame = self.statusBarFrame;
    
    self.statusBarView.frame = CGRectMake(self.statusBarView.frame.origin.x, self.statusBarView.frame.origin.y, self.statusBarView.frame.size.width, self.statusBarView.frame.size.height);
    
    
}

//---[ Received AFTER statusbar frame change ]---
//notification from AppDelegate.m - (void) application:(UIApplication *)application didChangeStatusBarFrame:(CGRect)oldStatusBarFrame
- (void)statusBarFrameChangedFullScreenView:(NSNotification*)notification
{
   // NSLog(@"%s",__PRETTY_FUNCTION__);
    
    [self adjustFullScreenView];
    
}

- (void)initStatusBarView
{
    //NSLog(@"%s",__PRETTY_FUNCTION__);
    
    self.statusBarView = [UIView new];
    
    [self.view addSubview:self.statusBarView];
    
    //status-bar color:
    self.statusBarView.backgroundColor = [UIColor blackColor];
 
    //init status bar frame
    self.statusBarFrame = [UIApplication sharedApplication].statusBarFrame;
    self.statusBarView.frame = self.statusBarFrame;
    self.statusBarView.frame = CGRectMake(self.statusBarView.frame.origin.x, self.statusBarView.frame.origin.y, self.statusBarView.frame.size.width, self.statusBarView.frame.size.height);
    
   
}

- (void)initFullScreenView
{
    //NSLog(@"%s",__PRETTY_FUNCTION__);
    
    self.fullScreenView = [UIView new];
    
    [self.view addSubview:self.fullScreenView];
    
    //FullScreen color:
    self.fullScreenView.backgroundColor = [UIColor clearColor];
    
    [self adjustFullScreenView];
    
    
}


- (void)viewDidLoad
{
    //NSLog(@"%s",__PRETTY_FUNCTION__);

    [super viewDidLoad];
    
    //Observers for status bar changing size
    [self setupObservers];
    
    //Master View
    self.view.backgroundColor = [UIColor clearColor];
    
    //create the statusBarView - 20 height defined as enum
    [self initStatusBarView];
    
    //create the fullScreenView - everything except the statusbar
    [self initFullScreenView];
    
    //Add ViewController as the main view
    [self initKwickieVCtoFullscreenView];  //kwickieVC
    
}

- (void) initKwickieVCtoFullscreenView
{
    //NSLog(@"%s",__PRETTY_FUNCTION__);
    
    //ViewController inside a UIVIEW:
    //Put self.kwickieVC inside self.fullScreenView

    self.kwickieVC = [[KwickieViewController alloc] init];
    self.kwickieVC.view.frame = self.fullScreenView.bounds;
    
    [self addChildViewController:self.kwickieVC];
    
    [self.fullScreenView addSubview:self.kwickieVC.view];

    [self.kwickieVC didMoveToParentViewController:self];

}

- (void)didReceiveMemoryWarning
{
    //NSLog(@"%s",__PRETTY_FUNCTION__);
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.


}



@end
