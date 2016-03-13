//
//  KwickieViewController.m
//  kwickieTim
//
//  Created by Test on 13/03/2016.
//  Copyright © 2016 Tim. All rights reserved.
//

#import "KwickieViewController.h"
#import "KwickieTableViewCell.h"

#import "PlayVideoStreamVC.h"


@interface KwickieViewController ()

@end

@implementation KwickieViewController

- (void)initAutoLayout
{
    NSLog(@"%s",__PRETTY_FUNCTION__);
    
    //Setup Auto-Layout:
    
    NSDictionary *viewsDictionary = @{
                                      @"tableView":self.kwickieTableView,
                                      @"heading":self.headingView,
                                      };
    
    
    //Sizes of views
    NSArray *constraintSizes =  [NSLayoutConstraint constraintsWithVisualFormat:@"V:[heading(50)]"
                                                                            options:0
                                                                            metrics:nil
                                                                              views:viewsDictionary];
    [self.headingView addConstraints:constraintSizes];

 

    //Auto-Layout constraints of views
    NSArray *constraintHorizontal1 =  [NSLayoutConstraint constraintsWithVisualFormat:@"H:|[heading]|"
                                                                              options:0
                                                                              metrics:nil
                                                                                views:viewsDictionary];
    NSArray *constraintHorizontal2 =  [NSLayoutConstraint constraintsWithVisualFormat:@"H:|[tableView]|"
                                                                             options:0
                                                                             metrics:nil
                                                                               views:viewsDictionary];

    NSArray *constraintVertical =  [NSLayoutConstraint constraintsWithVisualFormat:@"V:|[heading]-2-[tableView]|"
                                                                             options:0
                                                                             metrics:nil
                                                                               views:viewsDictionary];
    
    
    [self.view addConstraints:constraintHorizontal1];
    [self.view addConstraints:constraintHorizontal2];
    [self.view addConstraints:constraintVertical];
    
    
    
}


- (void)viewDidLoad
{
    NSLog(@"%s",__PRETTY_FUNCTION__);

    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor clearColor];
    
    [self initTableView];
    [self initHeadingView]; //testing
    
    
    [self initAutoLayout];
    
    [self initStreamPlayer];
    
    [self startObserver:@"reloadTableView"]; //reload tableView
    
}

- (void)didReceiveMemoryWarning
{
    NSLog(@"%s",__PRETTY_FUNCTION__);

    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.

}

- (void) initTableView
{
    NSLog(@"%s",__PRETTY_FUNCTION__);

    self.kwickieTableView = [UITableView new];
    self.kwickieTableView.backgroundColor = [UIColor whiteColor];

    self.kwickieTableView.autoresizingMask = UIViewAutoresizingNone;
    self.kwickieTableView.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:self.kwickieTableView];
    
    [self.kwickieTableView registerClass:[KwickieTableViewCell class] forCellReuseIdentifier:cellIdentifier];
    
    
    self.kwickieTableViewDataSource = [KwickieTableViewDataSource new];
    self.kwickieTableView.delegate = self.kwickieTableViewDataSource;
    self.kwickieTableView.dataSource = self.kwickieTableViewDataSource;
    [self.kwickieTableViewDataSource startObserver:@"newTableViewData"];
    
    
}

- (void) initHeadingView
{
    NSLog(@"%s",__PRETTY_FUNCTION__);

    self.headingView = [UIView new];
    self.headingView.backgroundColor = [UIColor clearColor];
    self.headingView.autoresizingMask = UIViewAutoresizingNone;
    self.headingView.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:self.headingView];


    
    UILabel *headingLabel = [[UILabel alloc] init];
    headingLabel.backgroundColor = [UIColor greenColor];
    headingLabel.textColor = [UIColor whiteColor];
    headingLabel.textAlignment = NSTextAlignmentCenter;
    headingLabel.font = [UIFont fontWithName:@"HelveticaNeue-Bold" size:26.0f];
    headingLabel.text = @"Kwickie";
    headingLabel.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    [self.headingView addSubview:headingLabel];

}

- (void) initStreamPlayer
{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(streamVideo:) name:@"streamVideo" object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(streamVideoStop:) name:@"streamVideoSTop" object:nil];
    
}


- (void) startObserver:(NSString *)notificationsName;
{
    NSLog(@"%s",__PRETTY_FUNCTION__);
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(newTableViewData:) name:notificationsName object:nil];
}

- (void) newTableViewData:(NSNotification *)notification
{
    NSLog(@"%s",__PRETTY_FUNCTION__);

    [self.kwickieTableView performSelectorOnMainThread:@selector(reloadData) withObject:nil waitUntilDone:NO];
}

- (void) streamVideo:(NSNotification *)notification
{
    NSDictionary *notification_dict = [notification userInfo];
    NSString *url = [notification_dict objectForKey:@"URL"];
    
    //NSLog(@"url = [%@]", url);
    
    PlayVideoStreamVC *myPlayerVC = [[PlayVideoStreamVC alloc] init];
    myPlayerVC.url = url;
    
    if (![self.presentedViewController isBeingPresented])
    {
        [self presentViewController:myPlayerVC animated:YES completion:nil];
    }
    
}

- (void) streamVideoStop:(NSNotification *)notification
{
    

    if (![self.presentedViewController isBeingDismissed])
    {
        [self dismissViewControllerAnimated:YES completion:nil];
    }
    
}


@end
