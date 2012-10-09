//
//  Status.h
//  Huskr
//
//  Created by Jared Egan on 10/3/12.
//  Copyright 2012 Jared Egan. All rights reserved.
//

#import <Foundation/Foundation.h>

////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////
@interface Status : NSObject {

}

@property (nonatomic, copy) NSNumber *objectID;
@property (nonatomic, copy) NSString *username;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, strong) NSDate *createdDate;
@property (nonatomic, strong) NSDate *updatedDate;

/**
 *  Given a NSDictionary (created from JSON), return a populated Status object.
 */
+ (Status *)statusFromJSONDictionary:(NSDictionary *)JSONDictionary;

@end
