//
//  PlayVideoStreamVC.m
//  kwickieTim
//
//  Created by Test on 13/03/2016.
//  Copyright © 2016 Tim. All rights reserved.
//

#import "PlayVideoStreamVC.h"
#import <AVFoundation/AVFoundation.h>
#import <AVKit/AVKit.h>


@interface PlayVideoStreamVC ()

@end

@implementation PlayVideoStreamVC

- (void)viewDidLoad
{
    NSLog(@"%s",__PRETTY_FUNCTION__);
    
    [super viewDidLoad];
    
    NSURL *url = [NSURL URLWithString:self.url];
    AVURLAsset *asset = [AVURLAsset assetWithURL: url];
    AVPlayerItem *item = [AVPlayerItem playerItemWithAsset: asset];
    
    self.player = [[AVPlayer alloc] initWithPlayerItem: item];

    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(streamVideoSTop)
                                                 name:AVPlayerItemDidPlayToEndTimeNotification
                                               object:[self.player currentItem]];
    
    [self.player play];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) streamVideoSTop
{
    NSLog(@"%s",__PRETTY_FUNCTION__);
    
     self.player = nil;
    
    // received by KwickieViewController:   - (void) streamVideoStop:(NSNotification *)notification
    [[NSNotificationCenter defaultCenter] postNotificationName:@"streamVideoSTop" object:self userInfo:nil];

}

@end
