//
//  APISectionViewController.m
//  IOSProgrammerTest
//
//  Created by Justin LeClair on 12/15/14.
//  Copyright (c) 2014 AppPartner. All rights reserved.
//

#import "LoginSectionViewController.h"
#import "MainMenuViewController.h"

@interface LoginSectionViewController ()

@end

@implementation LoginSectionViewController{
    UIAlertController *alertController;
}

@synthesize userName;
@synthesize userPassword;
@synthesize loginBg;
- (void)viewDidLoad
{
    [super viewDidLoad];
    // Font setup
    self.userPassword.placeholder = [NSString stringWithFormat:@"password"];
    self.userPassword.font = [UIFont fontWithName:@"Machinato" size:22];
    self.userName.placeholder = [NSString stringWithFormat:@"username"];
    self.userName.font = [UIFont fontWithName:@"Machinato" size:22];
    
    // Backgroud image setup
    loginBg.contentMode = UIViewContentModeScaleAspectFill;
    loginBg.clipsToBounds = YES;
}

/* Description: login button handler */
- (IBAction)loginClicked:(id)sender {
    @try {
        
        // If textfield is returned with nil
        if([[self.userName text] isEqualToString:@""] || [[self.userPassword text] isEqualToString:@""] ) {
            [self alertStatus:@"Please enter Email and Password" :@"Sign in Failed!" :0];
        }
        
        else {
            // Prepare for sending POST
            NSOperationQueue *mainQueue = [[NSOperationQueue alloc] init];
            [mainQueue setMaxConcurrentOperationCount:5];
            NSURL *url = [NSURL URLWithString:@"http://dev.apppartner.com/AppPartnerProgrammerTest/scripts/login.php"];
            NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:url];
            NSString *sendData = @"username=";
            sendData = [sendData stringByAppendingString:[NSString stringWithFormat:@"%@", [self.userName text]]];
            
            sendData = [sendData stringByAppendingString:@"&password="];
            sendData = [sendData stringByAppendingString:[NSString stringWithFormat:@"%@", [self.userPassword text]]];
            
            [request setHTTPBody:[sendData dataUsingEncoding:NSUTF8StringEncoding]];
            
            [request setHTTPMethod:@"POST"];
            [request addValue:[self.userName text] forHTTPHeaderField:@"username"];
            [request addValue:[self.userPassword text] forHTTPHeaderField:@"password"];
            NSDate *methodStart = [NSDate date];
            // Send POST
            [NSURLConnection sendAsynchronousRequest:request queue:mainQueue completionHandler:^(NSURLResponse *response, NSData *responseData, NSError *error) {
                NSDate *methodFinish = [NSDate date];
                NSTimeInterval executionTime = [methodFinish timeIntervalSinceDate:methodStart];
                NSError *jsonErr;
                NSHTTPURLResponse *urlResponse = (NSHTTPURLResponse *)response;
                NSDictionary *json;
                NSString *code;
                NSString *message;
                if (responseData != nil) {
                    // Parse Json response
                    json = [NSJSONSerialization JSONObjectWithData:responseData options:kNilOptions error:&jsonErr];
                    message = json[@"message"];
                    code = json[@"code"];
                }

                if (![code isEqualToString:@"Error"] && responseData != nil) {
                    
                    // Sign in success
                    alertController = [UIAlertController
                                                          alertControllerWithTitle:@"login success"
                                                          message:[NSString stringWithFormat:@"message: %@, code: %@, time took: %.3f",message,code, executionTime]
                                                          preferredStyle:UIAlertControllerStyleAlert];
                    
                    UIAlertAction *okAction = [UIAlertAction
                                               actionWithTitle:NSLocalizedString(@"OK", @"OK action")
                                               style:UIAlertActionStyleDefault
                                               handler:^(UIAlertAction *action)
                                               {
                                                   [self.navigationController popToRootViewControllerAnimated:YES];

                                               }];
                    [alertController addAction:okAction];
                    [self performSelectorOnMainThread:@selector(showAlert) withObject:nil waitUntilDone:NO];
                        
                    NSLog(@"Status Code: %li %@", (long)urlResponse.statusCode, [NSHTTPURLResponse localizedStringForStatusCode:urlResponse.statusCode]);
                    NSLog(@"Response Body: %@", [[NSString alloc] initWithData:responseData encoding:NSUTF8StringEncoding]);
                }
                else {
                    
                    // Sign in fail alert
                    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"login failed" message:[NSString stringWithFormat:@"message: %@, code: %@, time took: %.3f",message,code,executionTime] delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
                    [alert performSelectorOnMainThread:@selector(show) withObject:nil waitUntilDone:NO];
                    
                    NSLog(@"An error occured, Status Code: %li", (long)urlResponse.statusCode);
                    NSLog(@"Description: %@", [error localizedDescription]);

                }
            }];


            
        }
    }
    @catch (NSException * e) {
        NSLog(@"Exception: %@", e);
    }
}

/* Description: Textfield return handler */
-(BOOL) textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}

/* Description: Backgroup tap handler */
- (IBAction)backgroundTap:(id)sender {
    [self.view endEditing:YES];
}

/* Description: Present alert controller */
-(void) showAlert {
    [self presentViewController:alertController animated:YES completion:nil];
}

/* Description: Show alert */
- (void) alertStatus:(NSString *)msg :(NSString *)title :(int) tag
{
    NSLog(@"here");
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:title
                                                        message:msg
                                                       delegate:self
                                              cancelButtonTitle:@"Ok"
                                              otherButtonTitles:nil, nil];
    alertView.tag = tag;
    [alertView show];
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
