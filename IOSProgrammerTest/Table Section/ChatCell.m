//
//  TableSectionTableViewCell.m
//  IOSProgrammerTest
//
//  Created by Justin LeClair on 12/15/14.
//  Copyright (c) 2014 AppPartner. All rights reserved.
//

#import "ChatCell.h"
#define FONT_M_L(s) [UIFont fontWithName:@"Machinato Light.ttf" size:s]
#define FONT_M_R(s) [UIFont fontWithName:@"Machinato.ttf" size:s]
#define FONT_M_EL(s) [UIFont fontWithName:@"Machinato ExtraLight.ttf" size:s]

@interface ChatCell ()
@end

@implementation ChatCell
@synthesize usernameLabel;
@synthesize messageTextView;
@synthesize userIcon;
- (void)awakeFromNib
{
    // Initialization code
}

- (void)loadWithData:(ChatData *)chatData
{
    self.usernameLabel.text = chatData.username;
//    self.usernameLabel.font = FONT_M_R(19);
    self.messageTextView.text = chatData.message;
//    self.messageTextView.font = FONT_M_L(15);
    NSURL * imageURL = [NSURL URLWithString:chatData.avatar_url];
    NSData * imageData = [NSData dataWithContentsOfURL:imageURL];
    self.userIcon.image = [UIImage imageWithData:imageData];
    self.userIcon.clipsToBounds = YES;
    [self setRoundedView:self.userIcon];
}

/* Description: Helper function to get round icon */
-(void)setRoundedView:(UIImageView *)roundedView
{
    roundedView.layer.cornerRadius = roundedView.frame.size.height /2;
    roundedView.layer.masksToBounds = YES;
    roundedView.layer.borderWidth = 0.1;
}

@end
