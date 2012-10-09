//
//  StatusController.m
//  Huskr
//
//  Created by Jared Egan on 10/8/12.
//  Copyright 2012 Jared Egan. All rights reserved.
//

#import "StatusController.h"

#import "Status.h"
#import "ConfigManager.h"

#import "AFNetworking.h"
#import "AFJSONRequestOperation.h"

#import "NimbusCore.h"

////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////
@interface StatusController()

@end

////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////
@implementation StatusController

#pragma mark -
#pragma mark Init & Factory
////////////////////////////////////////////////////////////////////////////////////////////////////
- (id)init {
    self = [super init];
	if (self) {
		// Custom init goes here
	}
	
	return self;
}

////////////////////////////////////////////////////////////////////////////////////////////////////
- (void)dealloc {
	
}

#pragma mark -
#pragma mark StatusController
////////////////////////////////////////////////////////////////////////////////////////////////////
- (void)loadStatuses {
    AFHTTPClient *httpClient = [[AFHTTPClient alloc] initWithBaseURL:[NSURL URLWithString:[ConfigManager instance].apiBaseURL]];
    NSMutableURLRequest *request = [httpClient requestWithMethod:@"GET"
                                                            path:@"/api/v1/statuses.json"
                                                      parameters:nil];

    NSLog(@"Loading statuses with URL: %@", [request.URL absoluteString]);


    AFJSONRequestOperation *operation = [AFJSONRequestOperation
                                         JSONRequestOperationWithRequest:request
                                         success:^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON) {
                                             //[[TFHUDManager sharedInstance] hideAllHUDsAnimated:NO];
                                             NSLog(@"JSON Response: %@", JSON);

//                                             [[TFHUDManager sharedInstance] hideAllHUDsAnimated:NO];
//                                             [[TFHUDManager sharedInstance] showNotificationWithText:@"Twitter sync'd"
//                                                                                           imageType:TFHUDImageCheckMark];
                                             
                                             NSArray *jsonArray = JSON;

                                             NSAssert([jsonArray isKindOfClass:[NSArray class]], @"Expect an array as JSON response");
                                             
                                             NSMutableArray *results = [NSMutableArray array];
                                             
                                             for (NSDictionary *dictionary in JSON) {
                                                 Status *status = [Status statusFromJSONDictionary:dictionary];
                                                 [results addObject:status];
                                             }
                                             
                                             // Alert the delegate
                                             if ([self.delegate respondsToSelector:@selector(didLoadStatuses:)]) {
                                                 [self.delegate didLoadStatuses:results];
                                             }
                                             
                                         }
                                         failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error, id JSON) {
                                             // Load failed :(
                                             
                                             // Alert the delegate
                                             if ([self.delegate respondsToSelector:@selector(didFailLoadWithError:)]) {
                                                 [self.delegate didFailLoadWithError:error];
                                             }
                                         }];
    [operation start];
}

////////////////////////////////////////////////////////////////////////////////////////////////////
- (void)createStatus:(Status *)status {
    
}

@end
