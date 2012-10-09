//
//  CreateStatusViewController.m
//  Huskr
//
//  Created by Jared Egan on 10/8/12.
//  Copyright 2012 Jared Egan. All rights reserved.
//

#import "CreateStatusViewController.h"
#import "Status.h"
#import "MBProgressHUD.h"
#import "StatusController.h"

////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////
@interface CreateStatusViewController() <StatusControllerDelegate>

@property (nonatomic, weak) IBOutlet UITextField *usernameTextField;
@property (nonatomic, weak) IBOutlet UITextView *statusTextView;

@end

////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////
@implementation CreateStatusViewController

#pragma mark -
#pragma mark Init & Factory
////////////////////////////////////////////////////////////////////////////////////////////////////
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = NSLocalizedString(@"Post", @"Post");
        self.tabBarItem.image = [UIImage imageNamed:@"08-chat"];
    }
    return self;
}

////////////////////////////////////////////////////////////////////////////////////////////////////
- (void)dealloc {
	
}

#pragma mark -
#pragma mark UIViewController
////////////////////////////////////////////////////////////////////////////////////////////////////
- (void)viewDidLoad {
    [super viewDidLoad];
    
}


#pragma mark -
#pragma mark CreateStatusViewController
////////////////////////////////////////////////////////////////////////////////////////////////////
- (IBAction)postButtonPressed:(id)sender {
    // Construct a status and tell our controller to create it.
}

#pragma mark -
#pragma mark StatusControllerDelegate
////////////////////////////////////////////////////////////////////////////////////////////////////
- (void)didCreateStatus:(Status *)status {
    MBProgressHUD *HUD = [[MBProgressHUD alloc] initWithView:self.navigationController.view];
	[self.navigationController.view addSubview:HUD];
	
	// The sample image is based on the work by http://www.pixelpressicons.com, http://creativecommons.org/licenses/by/2.5/ca/
	// Make the customViews 37 by 37 pixels for best results (those are the bounds of the build-in progress indicators)
	HUD.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"37x-Checkmark.png"]];
	
	// Set custom view mode
	HUD.mode = MBProgressHUDModeCustomView;
	
	//HUD.delegate = self;
	HUD.labelText = @"Completed";
	
	[HUD show:YES];
	[HUD hide:YES afterDelay:3];
    
    // Clear the view
    self.statusTextView.text = nil;
}

////////////////////////////////////////////////////////////////////////////////////////////////////
- (void)didFailStatusCreationForStatus:(Status *)status withError:(NSError *)error {
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Could not create status"
                                                    message:[error localizedDescription]
                                                   delegate:nil
                                          cancelButtonTitle:@"OK"
                                          otherButtonTitles:nil];
    [alert show];
}


@end
