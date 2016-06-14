//
//  ViewController.m
//  RSAlertControllerExample
//
//  Created by Rushi Sangani on 12/06/16.
//  Copyright © 2016 Rushi Sangani. All rights reserved.
//

#import "ViewController.h"
#import "RSAlertViewController.h"

@interface ViewController ()

- (IBAction)alert1Clicked:(id)sender;
- (IBAction)alert2Clicked:(id)sender;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (IBAction)alert1Clicked:(id)sender {
    
    [[RSAlertViewController sharedInstance] showAlertWithTitle:@"Alert" message:@"Do you want to confirm?" buttons:@[@"Cancel", @"OK"] fromViewController:self withActionHandler:^(NSUInteger buttonIndex) {
      
        NSLog(@"button clicked at Index %lu", buttonIndex);
    }];
}

- (IBAction)alert2Clicked:(id)sender {
    
    RSAlertViewController *alertView = [[RSAlertViewController sharedInstance] showAlertWithTitle:@"Success" message:@"Do you want to proceed?\n\nAnswer by selecting one of the three option.\n\nDo you want to proceed?\n\nAnswer by selecting one of the three option.\n\nDo you want to proceed?\n\nAnswer by selecting one of the three option.\n\nDo you want to proceed?\n\nAnswer by selecting one of the three option.\n\nDo you want to proceed?\n\nAnswer by selecting one of the three option.\n\nDo you want to proceed?\n\nAnswer by selecting one of the three option.\n\nDo you want to proceed?\n\nAnswer by selecting one of the three option.\n\nDo you want to proceed?\n\nAnswer by selecting one of the three option.\n\nDo you want to proceed?\n\nAnswer by selecting one of the three option." buttons:@[@"No", @"Yes", @"Never"] fromViewController:self withActionHandler:^(NSUInteger buttonIndex) {
        
        NSLog(@"button clicked at Index %lu", buttonIndex);
        
    }];
    
    alertView.dismissOnTapOutside = YES;
    alertView.textAlignment = NSTextAlignmentLeft;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
