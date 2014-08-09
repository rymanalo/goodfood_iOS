//
//  GFAboutViewController.m
//  GoodFood
//
//  Created by Ryan Manalo on 8/8/14.
//  Copyright (c) 2014 Manalo. All rights reserved.
//

#import "GFAboutViewController.h"

@interface GFAboutViewController ()
@property(nonatomic,assign) id<MFMailComposeViewControllerDelegate> mailComposeDelegate;
@end

@implementation GFAboutViewController
{
    MFMailComposeViewController *mailComposer;
}


- (IBAction)emailAndrisLukjanovics:(id)sender {
    mailComposer = [[MFMailComposeViewController alloc]init];
    mailComposer.mailComposeDelegate = self;
    [mailComposer setToRecipients:@[@"andris310@gmail.com"]];
    [mailComposer setSubject:@"GoodFood iOS User"];
    [mailComposer setMessageBody:@"Hey Andris,<br>" isHTML:YES];
    [self presentViewController:mailComposer animated:YES completion:nil];
}


- (IBAction)emailPhilDiNuzzo:(id)sender {
    mailComposer = [[MFMailComposeViewController alloc]init];
    mailComposer.mailComposeDelegate = self;
    [mailComposer setToRecipients:@[@"phil248@gmail.com"]];
    [mailComposer setSubject:@"GoodFood iOS User"];
    [mailComposer setMessageBody:@"Hey Phil,<br>" isHTML:YES];
    [self presentViewController:mailComposer animated:YES completion:nil];
}

- (IBAction)emailRyanManalo:(id)sender {
    mailComposer = [[MFMailComposeViewController alloc]init];
    mailComposer.mailComposeDelegate = self;
    [mailComposer setToRecipients:@[@"r@ryanmanalo.com"]];
    [mailComposer setSubject:@"GoodFood iOS User"];
    [mailComposer setMessageBody:@"Hey Ryan,<br>I am enjoying your app!" isHTML:YES];
    [self presentViewController:mailComposer animated:YES completion:nil];
    
}

- (IBAction)emailSherodTaylor:(id)sender {
    mailComposer = [[MFMailComposeViewController alloc]init];
    mailComposer.mailComposeDelegate = self;
    [mailComposer setToRecipients:@[@"sherodtaylor@gmail.com"]];
    [mailComposer setSubject:@"GoodFood iOS User"];
    [mailComposer setMessageBody:@"Hey Sherod,<br>" isHTML:YES];
    [self presentViewController:mailComposer animated:YES completion:nil];
}



- (void) mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error
{
    switch (result)
    {
        case MFMailComposeResultCancelled:
            NSLog(@"Mail cancelled");
            break;
        case MFMailComposeResultSaved:
            NSLog(@"Mail saved");
            break;
        case MFMailComposeResultSent:
            NSLog(@"Mail sent");
            break;
        case MFMailComposeResultFailed:
            NSLog(@"Mail sent failure: %@", [error localizedDescription]);
            break;
        default:
            break;
    }
    
    // Close the Mail Interface
    [self dismissViewControllerAnimated:YES completion:NULL];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
