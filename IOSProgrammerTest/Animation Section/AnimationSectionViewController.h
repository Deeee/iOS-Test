//
//  AnimationSectionViewController.h
//  IOSProgrammerTest
//
//  Created by Justin LeClair on 12/15/14.
//  Copyright (c) 2014 AppPartner. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AnimationSectionViewController : UIViewController<UIGestureRecognizerDelegate>
@property (weak, nonatomic) IBOutlet UIImageView *animBg;
@property (weak, nonatomic) IBOutlet UILabel *prompt;
@property (weak, nonatomic) IBOutlet UIImageView *animCell;
@property (strong, nonatomic) IBOutlet UIImageView *icon;
@property (weak, nonatomic) IBOutlet UIButton *spinButton;
@property (nonatomic, assign) CGPoint touchOffset;
@property (nonatomic, assign) CGPoint homePosition;
@property (nonatomic, strong) UIImageView *dragObject;
@property (nonatomic, strong) UIImageView *dropObject;
@property (nonatomic, strong) UILabel *promptWindow;
-(IBAction)longPressBegan:(UILongPressGestureRecognizer *)recognizer;

@end
