//
//  AnimationSectionViewController.m
//  IOSProgrammerTest
//
//  Created by Justin LeClair on 12/15/14.
//  Copyright (c) 2014 AppPartner. All rights reserved.
//

#import "AnimationSectionViewController.h"
#import "MainMenuViewController.h"

@interface AnimationSectionViewController ()

@end

@implementation AnimationSectionViewController {
    BOOL isTouched;
    BOOL isMoved;
    BOOL isLayerPaused;
}
@synthesize animBg;
@synthesize prompt;
@synthesize animCell;
@synthesize icon;
@synthesize touchOffset;
@synthesize homePosition;
@synthesize dragObject;
@synthesize dropObject;
@synthesize promptWindow;
@synthesize spinButton;
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Setup images on the view
    animBg.contentMode = UIViewContentModeScaleAspectFill;
    animBg.clipsToBounds = YES;
    animCell.contentMode = UIViewContentModeScaleAspectFill;
    animCell.clipsToBounds = YES;
    icon.contentMode = UIViewContentModeScaleAspectFit;
    icon.clipsToBounds = YES;
    
    // Setup logic flags
    isTouched = NO;
    isMoved = NO;
    isLayerPaused = NO;
    
    // Setup prompt window for icon animation
    [prompt sizeToFit];
    [prompt setLineBreakMode:NSLineBreakByWordWrapping];
    [prompt setNumberOfLines:0];
    promptWindow = [[UILabel alloc] initWithFrame:CGRectMake(spinButton.frame.origin.x, spinButton.frame.origin.y - 50, spinButton.frame.size.width, spinButton.frame.size.height)];
    promptWindow.backgroundColor = [UIColor whiteColor];
    promptWindow.alpha = 0.6;
    promptWindow.numberOfLines = 0;
    promptWindow.text = @"While long pressing, move left or right on the button to activate and speed up icon animation!";
    promptWindow.font = [UIFont fontWithName:@"Machinato" size:12];
    promptWindow.hidden = YES;
    [self.view addSubview:promptWindow];
    
    
    
}
/* Description: drag gesture handler */
- (void)touchesBegan: (NSSet *)touches withEvent:(UIEvent *)event
{
    // One finger drag
    if ([touches count] == 1) {
        CGPoint touchPoint = [[touches anyObject] locationInView:self.view];
        for (UIImageView *iView in self.view.subviews) {
            if ([iView isMemberOfClass:[UIImageView class]] && iView == icon) {
                if (touchPoint.x > iView.frame.origin.x &&
                    touchPoint.x < iView.frame.origin.x + iView.frame.size.width &&
                    touchPoint.y > iView.frame.origin.y &&
                    touchPoint.y < iView.frame.origin.y + iView.frame.size.height)
                {
                    isTouched = YES;
                    dragObject = iView;
                    touchOffset = CGPointMake(touchPoint.x - iView.frame.origin.x,
                                                   touchPoint.y - iView.frame.origin.y);
                    homePosition = CGPointMake(iView.frame.origin.x,
                                                    iView.frame.origin.y);
                    [self.view bringSubviewToFront:dragObject];
                    
                }
            }
        }
    }
    
    
}

/* Description: drag gesture handler */
- (void)touchesMoved: (NSSet *)touches withEvent:(UIEvent *)event
{
    // If touch moved has not been invoked, enlarge drag object and decrease alpha
    if (isMoved == 0 && isTouched == 1) {
        [dragObject setAlpha:0.7];
        CGPoint touchPoint = [[touches anyObject] locationInView:self.view];
        CGRect newDragObjectFrame = CGRectMake(touchPoint.x - touchOffset.x,
                                               touchPoint.y - touchOffset.y,
                                               self.dragObject.frame.size.width + 20,
                                               self.dragObject.frame.size.height + 20);
        self.dragObject.frame = newDragObjectFrame;
        isMoved = 1;
    }
    // If touch moved has been invoked, do not enlarge drag object
    else if(isTouched == 1){
        CGPoint touchPoint = [[touches anyObject] locationInView:self.view];
        CGRect newDragObjectFrame = CGRectMake(touchPoint.x - touchOffset.x,
                                               touchPoint.y - touchOffset.y,
                                               self.dragObject.frame.size.width,
                                               self.dragObject.frame.size.height);
        self.dragObject.frame = newDragObjectFrame;
    }
}

/* Description: drag gesture handler */
- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    // Settle down the drag object and reset alpha
    [dragObject setAlpha:1];
    if (isTouched == 1 && isMoved == 1) {
        isMoved = 0;
        isTouched = 0;
        self.dragObject.frame = CGRectMake(dragObject.frame.origin.x, dragObject.frame.origin.y,
                                           self.dragObject.frame.size.width - 20,
                                           self.dragObject.frame.size.height - 20);
    }
}

/* Description: Rotate App partner icon in a infinity fashion */
-(void) rotateImageView {
    [UIView animateWithDuration:1 delay:0 options:UIViewAnimationOptionCurveLinear|UIViewAnimationOptionAllowUserInteraction|UIViewAnimationOptionBeginFromCurrentState animations:^{
        [self.icon setTransform:CGAffineTransformRotate(self.icon.transform, M_PI_2)];
    }completion:^(BOOL finished) {
        if (finished) {
            [self rotateImageView];
        }
    }];
}

/* Description: Helper function for resize image */
- (UIImage *)imageResize :(UIImage*)img andResizeTo:(CGSize)newSize
{
    CGFloat scale = [[UIScreen mainScreen]scale];
    UIGraphicsBeginImageContextWithOptions(newSize, NO, scale);
    [img drawInRect:CGRectMake(0,0,newSize.width,newSize.height)];
    UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}


/* Description: Function to animate icon */
- (void) iconAnimation{
    // Create image array that contains 46 frames for icon animation
    NSArray *imageNames = @[@"icon_apppartner0.png",@"icon_apppartner1.png",@"icon_apppartner2.png",@"icon_apppartner3.png",@"icon_apppartner4.png",@"icon_apppartner5.png",@"icon_apppartner6.png",@"icon_apppartner7.png",@"icon_apppartner8.png",@"icon_apppartner9.png",@"icon_apppartner10.png",@"icon_apppartner11.png",@"icon_apppartner12.png",@"icon_apppartner13.png",@"icon_apppartner14.png",@"icon_apppartner15.png",@"icon_apppartner16.png",@"icon_apppartner17.png",@"icon_apppartner18.png",@"icon_apppartner19.png",@"icon_apppartner20.png",@"icon_apppartner21.png",@"icon_apppartner22.png",@"icon_apppartner23.png",@"icon_apppartner24.png",@"icon_apppartner25.png",@"icon_apppartner26.png",@"icon_apppartner27.png",@"icon_apppartner28.png",@"icon_apppartner29.png",@"icon_apppartner30.png",@"icon_apppartner31.png",@"icon_apppartner32.png",@"icon_apppartner33.png",@"icon_apppartner34.png",@"icon_apppartner35.png",@"icon_apppartner36.png",@"icon_apppartner37.png",@"icon_apppartner38.png",@"icon_apppartner39.png",@"icon_apppartner40.png",@"icon_apppartner41.png",@"icon_apppartner42.png",@"icon_apppartner43.png",@"icon_apppartner44.png",@"icon_apppartner45.png",@"icon_apppartner46.png"];
    NSMutableArray *images = [[NSMutableArray alloc]init];
    CGSize size = CGSizeMake(300, 300);
    for (int i = 0; i < imageNames.count; i++) {
        UIImage *cur =[self imageResize:[UIImage imageNamed:[imageNames objectAtIndex:i]] andResizeTo:size];
        if (cur == nil) {
            NSLog(@"cannot find image!, %@",[imageNames objectAtIndex:i]);
        }
        [images addObject:cur];
    }
    icon.animationImages = images;
    icon.animationDuration = 1;
    [icon setAnimationRepeatCount:1];
    [icon startAnimating];
}

/* Description: Long press gesture handler */
-(IBAction)longPressBegan:(UILongPressGestureRecognizer *)recognizer
{
    if (recognizer.state == UIGestureRecognizerStateBegan)
    {
        // Long press detected, start animation
        // Resume animation if animation was paused
        if (isLayerPaused == YES) {
            [self resumeLayer:icon.layer];
        }
        // Start a new animation
        else {
            [self iconAnimation];
            [self rotateImageView];

        }
        // Show prompt for icon animation
        [UIView transitionWithView:promptWindow
                          duration:0.4
                           options:UIViewAnimationOptionTransitionCrossDissolve
                        animations:NULL
                        completion:NULL];
        self.promptWindow.hidden = NO;


    }
    // Speed up the icon animation when sliding within spin button
    else if(recognizer.state == UIGestureRecognizerStateChanged){
        if (![icon isAnimating]) {
            [self iconAnimation];
            [self rotateImageView];


        }
    }
    // Pause animation on the layer
    else
    {
        if (recognizer.state == UIGestureRecognizerStateCancelled
            || recognizer.state == UIGestureRecognizerStateFailed
            || recognizer.state == UIGestureRecognizerStateEnded)
        {
            [self pauseLayer:icon.layer];
            [UIView transitionWithView:promptWindow
                              duration:0.4
                               options:UIViewAnimationOptionTransitionCrossDissolve
                            animations:NULL
                            completion:NULL];
            // Hide prompt window
            self.promptWindow.hidden = YES;
        }
        
        
    }
}

/* Description: Function for pause layer
 Parameter: layer to pause */
-(void)pauseLayer:(CALayer*)layer {
    CFTimeInterval pausedTime = [layer convertTime:CACurrentMediaTime() fromLayer:nil];
    layer.speed = 0.0;
    layer.timeOffset = pausedTime;
    isLayerPaused = YES;
}

/* Description: Function for resume layer
   Parameter: layer to resume */
-(void)resumeLayer:(CALayer*)layer {
    CFTimeInterval pausedTime = [layer timeOffset];
    layer.speed = 1.0;
    layer.timeOffset = 0.0;
    layer.beginTime = 0.0;
    CFTimeInterval timeSincePause = [layer convertTime:CACurrentMediaTime() fromLayer:nil] - pausedTime;
    layer.beginTime = timeSincePause;
    isLayerPaused = NO;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)backAction:(id)sender
{
    MainMenuViewController *mainMenuViewController = [[MainMenuViewController alloc] init];
    [self.navigationController pushViewController:mainMenuViewController animated:YES];
}

@end
