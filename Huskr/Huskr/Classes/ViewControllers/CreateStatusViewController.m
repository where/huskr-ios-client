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
@interface CreateStatusViewController() <StatusControllerDelegate,
UITextFieldDelegate,
UITextViewDelegate> {
    
}

// UI
@property (nonatomic, weak) IBOutlet UITextField *usernameTextField;
@property (nonatomic, weak) IBOutlet UITextView *statusTextView;
@property (nonatomic, strong) MBProgressHUD *hud;

// Data
@property (nonatomic, strong) StatusController *statusController;

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
        
        // UI
        self.title = NSLocalizedString(@"Post", @"Post");
        self.tabBarItem.image = [UIImage imageNamed:@"08-chat"];
        
        // Data
        self.statusController = [[StatusController alloc] init];
        self.statusController.delegate = self;
    }
    return self;
}

////////////////////////////////////////////////////////////////////////////////////////////////////
- (void)dealloc {
	self.statusController.delegate = nil;
}

#pragma mark -
#pragma mark UIViewController
////////////////////////////////////////////////////////////////////////////////////////////////////
- (void)viewDidLoad {
    [super viewDidLoad];

    // shhh... Taking a shortcut!
    [(UIScrollView *)self.view setContentSize:CGSizeMake(self.view.frame.size.width, self.view.frame.size.height + 300)];
}

#pragma mark -
#pragma mark CreateStatusViewController
////////////////////////////////////////////////////////////////////////////////////////////////////
- (IBAction)postButtonPressed:(id)sender {
    // Show loading
    [self.hud hide:NO];
    self.hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [self.hud setLabelText:@"Loading..."];
    self.hud.userInteractionEnabled = YES; // Intercepts touch
    
    [self.statusController loadStatuses];
    
    // Kick off request to create
    Status *statusToCreate = [[Status alloc] init];
    statusToCreate.title = self.statusTextView.text;
    statusToCreate.username = self.usernameTextField.text;

    [self.statusController createStatus:statusToCreate];
}

#pragma mark -
#pragma mark StatusControllerDelegate
////////////////////////////////////////////////////////////////////////////////////////////////////
- (void)didCreateStatus:(Status *)status {
    [self.hud hide:NO];
    MBProgressHUD *HUD = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
	[self.navigationController.view addSubview:HUD];
	
	// The sample image is based on the work by http://www.pixelpressicons.com, http://creativecommons.org/licenses/by/2.5/ca/
	// Make the customViews 37 by 37 pixels for best results (those are the bounds of the build-in progress indicators)
	HUD.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"37x-Checkmark.png"]];
	
	// Set custom view mode
	HUD.mode = MBProgressHUDModeCustomView;
	
	//HUD.delegate = self;
	HUD.labelText = @"Status posted!";
	
	[HUD show:YES];
	[HUD hide:YES afterDelay:3];
    
    // Clear the view
    self.statusTextView.text = nil;
}

////////////////////////////////////////////////////////////////////////////////////////////////////
- (void)didFailStatusCreationForStatus:(Status *)status withError:(NSError *)error {
    [self.hud hide:NO];

    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Could not create status"
                                                    message:[error localizedDescription]
                                                   delegate:nil
                                          cancelButtonTitle:@"OK"
                                          otherButtonTitles:nil];
    [alert show];
}


#pragma mark -
#pragma mark UITextViewDelegate
////////////////////////////////////////////////////////////////////////////////////////////////////
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
    
    if([text isEqualToString:@"\n"]) {
        [textView resignFirstResponder];
        return NO;
    }
    
    return YES;
}


#pragma mark -
#pragma mark UITextFieldDelegate
////////////////////////////////////////////////////////////////////////////////////////////////////
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [self.statusTextView becomeFirstResponder];

    return YES;
}

@end
