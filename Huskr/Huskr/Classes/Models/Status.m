//
//  Status.m
//  Huskr
//
//  Created by Jared Egan on 10/3/12.
//  Copyright 2012 Jared Egan. All rights reserved.
//

#import "Status.h"

////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////
@interface Status()

@end

////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////
@implementation Status

#pragma mark -
#pragma mark Init & Factory
////////////////////////////////////////////////////////////////////////////////////////////////////
- (id)init {
    self = [super init];
	if (self) {

	}
	
	return self;
}

////////////////////////////////////////////////////////////////////////////////////////////////////
- (void)dealloc {
	
}

////////////////////////////////////////////////////////////////////////////////////////////////////
+ (Status *)statusFromJSONDictionary:(NSDictionary *)JSONDictionary {
    Status *result = [[self alloc] init];
    
    // TODO: Parse JSON Dictionary
    
    return result;
}

@end