//
//  ConfigManager.h
//  Huskr
//
//  Created by Jared Egan on 10/8/12.
//  Copyright 2012 Jared Egan. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum {
    ConfigEnvironmentProd,
    ConfigEnvironmentDev
} ConfigEnvironment;

////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////
@interface ConfigManager : NSObject {
    NSString *_apiBaseURL;
}

@property (nonatomic, assign) ConfigEnvironment currentEnvironment;
@property (nonatomic, readonly) NSString *apiBaseURL;

/*! Returns singleton instance */
+ (ConfigManager *)instance;

@end
