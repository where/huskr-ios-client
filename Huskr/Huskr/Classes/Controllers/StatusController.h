//
//  StatusController.h
//  Huskr
//
//  Created by Jared Egan on 10/8/12.
//  Copyright 2012 Jared Egan. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Status;

@protocol StatusControllerDelegate <NSObject>

@optional
- (void)didLoadStatuses:(NSArray *)results;
- (void)didFailLoadWithError:(NSError *)error;

- (void)didCreateStatus:(Status *)status;
- (void)didFailStatusCreationForStatus:(Status *)status withError:(NSError *)error;

@end

////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////
@interface StatusController : NSObject {

}

@property (nonatomic, weak) id<StatusControllerDelegate> delegate;

/**
 *  Kicks off a network request to load statuses.
 *  This class will alert it's delegate when the request completes or fails.
 */
- (void)loadStatuses;

/**
 *  Kicks off a network request to create a status;
 *  This class will alert it's delegate when the request completes or fails.
 */
- (void)createStatus:(Status *)status;

@end
