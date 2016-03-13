//
//  KwickieTableViewCell.h
//  kwickieTim
//
//  Created by Test on 13/03/2016.
//  Copyright © 2016 Tim. All rights reserved.
//

#import <UIKit/UIKit.h>

#define cellIdentifier @"KwickieCell"

@interface KwickieTableViewCell : UITableViewCell


@property (nonatomic, strong) UILabel *questionLabel;
@property (nonatomic, strong) UILabel *answerLabel;
@property (nonatomic, strong) UIImageView *kwickieImageView;


@end
