//
//  StatusListViewController.m
//  Huskr
//
//  Created by Jared Egan on 10/3/12.
//  Copyright 2012 Jared Egan. All rights reserved.
//

#import "StatusListViewController.h"
#import "Status.h"
#import "StatusController.h"
#import "NimbusCore.h"
#import "MBProgressHUD.h"
#import "StatusTableCell.h"

////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////
@interface StatusListViewController() <UITableViewDataSource,
UITableViewDelegate,
StatusControllerDelegate> {

    // This is a private category, an extension of the class.
    // It's one best practice for defining private properties and methods.
    
}

// UI
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UIBarButtonItem *refreshButton;
@property (nonatomic, strong) MBProgressHUD *hud;

// Data
@property (nonatomic, strong) NSArray *fetchedStatuses;
@property (nonatomic, strong) StatusController *statusController;

@end

////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////
@implementation StatusListViewController

#pragma mark -
#pragma mark Init & Factory
////////////////////////////////////////////////////////////////////////////////////////////////////
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
	if (self) {
        // UI
        self.title = @"Timeline";
        self.tabBarItem.image = [UIImage imageNamed:@"179-notepad"];
        
        // Data
        self.statusController = [[StatusController alloc] init];
        self.statusController.delegate = self;
	}
	
	return self;
}

////////////////////////////////////////////////////////////////////////////////////////////////////
- (void)dealloc {
	
    // Clear ourselves as delegates from weak pointers.
    // Otherwise other classes might send selectors to bad / reclaimed memory.
    self.statusController.delegate = nil;
}

#pragma mark -
#pragma mark UIViewController
////////////////////////////////////////////////////////////////////////////////////////////////////
- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Create table view
    self.tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    [self.view addSubview:self.tableView];
    
    // Navigation item
    self.refreshButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemRefresh
                                                                       target:self
                                                                       action:@selector(refreshButtonPressed)];
    self.navigationItem.rightBarButtonItem = self.refreshButton;

    // Kick of a network request
    [self loadStatuses];
}

////////////////////////////////////////////////////////////////////////////////////////////////////
- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:YES];
    
    self.tableView.frame = self.view.bounds;

}

////////////////////////////////////////////////////////////////////////////////////////////////////
- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    
}

#pragma mark -
#pragma mark StatusListViewController
////////////////////////////////////////////////////////////////////////////////////////////////////
- (void)refreshButtonPressed {
    [self loadStatuses];
}

////////////////////////////////////////////////////////////////////////////////////////////////////
- (void)loadStatuses {
    [self.hud hide:NO];
    self.hud = [MBProgressHUD showHUDAddedTo:self.navigationController.view animated:YES];
    [self.hud setLabelText:@"Loading..."];
    self.hud.userInteractionEnabled = YES; // Intercepts touch
    
    [self.statusController loadStatuses];
}

#pragma mark -
#pragma mark StatusControllerDelegate
////////////////////////////////////////////////////////////////////////////////////////////////////
- (void)didLoadStatuses:(NSArray *)results {
    [self.hud hide:YES];

    self.fetchedStatuses = results;

    [self.tableView reloadData];
}

////////////////////////////////////////////////////////////////////////////////////////////////////
- (void)didFailLoadWithError:(NSError *)error {
    [self.hud hide:NO];

    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Could not load statuses"
                                                    message:[error localizedDescription]
                                                    delegate:nil
                                          cancelButtonTitle:@"OK"
                                          otherButtonTitles:nil];
    [alert show];
}

#pragma mark -
#pragma mark UITableViewDatasource
////////////////////////////////////////////////////////////////////////////////////////////////////
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    if (self.fetchedStatuses != nil) {
        return [self.fetchedStatuses count];
    } else {
        return 0;
    }
}

// Row display. Implementers should *always* try to reuse cells by setting each cell's reuseIdentifier and querying for available reusable cells with dequeueReusableCellWithIdentifier:
// Cell gets various attributes set automatically based on table (separators) and data source (accessory views, editing controls)
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellReuseID = @"StatusTableCell";
    
    StatusTableCell *cell = [tableView dequeueReusableCellWithIdentifier:cellReuseID];
    if (cell == nil) {
        cell = [[StatusTableCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellReuseID];
    }
    
    // Configure cell
    Status *status = [self.fetchedStatuses objectAtIndex:indexPath.row];
    [cell setUpWithStatus:status];
    
    return cell;
}

// Additional protocol methods

//- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView;              // Default is 1 if not implemented
//
//- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section;    // fixed font style. use custom view (UILabel) if you want something different
//- (NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section;

#pragma mark -
#pragma mark UITableViewDelegate
////////////////////////////////////////////////////////////////////////////////////////////////////
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];

    // TODO: Possibly push a detail page for this status
}

// Variable height table cells
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 150;
}

@end


