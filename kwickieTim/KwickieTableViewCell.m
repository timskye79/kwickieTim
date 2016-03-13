//
//  KwickieTableViewCell.m
//  kwickieTim
//
//  Created by Test on 13/03/2016.
//  Copyright © 2016 Tim. All rights reserved.
//

#import "KwickieTableViewCell.h"

@implementation KwickieTableViewCell

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}


- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        // Initialization code
        
        
        self.questionLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 20, 200, 20)];
        self.questionLabel.textColor = [UIColor blackColor];
        self.questionLabel.font = [UIFont fontWithName:@"HelveticaNeue" size:16.0f];
        self.questionLabel.backgroundColor = [UIColor clearColor];
        self.questionLabel.text = @"";
        [self addSubview:self.questionLabel];

        self.answerLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 50, 200, 20)];
        self.answerLabel.textColor = [UIColor blackColor];
        self.answerLabel.font = [UIFont fontWithName:@"HelveticaNeue" size:16.0f];
        self.answerLabel.backgroundColor = [UIColor clearColor];
        self.answerLabel.text = @"";
        [self addSubview:self.answerLabel];


        self.kwickieImageView = [[UIImageView alloc] initWithFrame:CGRectMake(220, 0, 100, 100)];
        self.kwickieImageView.userInteractionEnabled = YES;
        self.kwickieImageView.backgroundColor = [UIColor clearColor];
        [self addSubview:self.kwickieImageView];
        
        
    }
    return self;
    
};

@end
