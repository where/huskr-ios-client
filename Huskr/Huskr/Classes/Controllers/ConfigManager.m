//
//  ConfigManager.m
//  Huskr
//
//  Created by Jared Egan on 10/8/12.
//  Copyright 2012 Jared Egan. All rights reserved.
//

#import "ConfigManager.h"

static NSString *kEnvironmentKey = @"huskr_environment";

static ConfigManager *instance;

////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////
@interface ConfigManager()

@end

////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////
@implementation ConfigManager

@synthesize apiBaseURL = _apiBaseURL;

#pragma mark -
#pragma mark Init & Factory
////////////////////////////////////////////////////////////////////////////////////////////////////
+ (ConfigManager *)instance {

	static dispatch_once_t pred;
    
	dispatch_once(&pred, ^
				  {
					  instance = [[self alloc] init];
				  });
    
	return instance;
}

////////////////////////////////////////////////////////////////////////////////////////////////////
- (id)init {
    self = [super init];
	if (self) {
        NSNumber *savedEnvironment = [[NSUserDefaults standardUserDefaults] objectForKey:kEnvironmentKey];
        
//#ifdef DEBUG
//        if (savedEnvironment == nil) {
//            [self setCurrentEnvironment:ConfigEnvironmentDev];
//        }
//#endif
        if (savedEnvironment != nil) {
            [self setCurrentEnvironment:[savedEnvironment intValue]];
        }
        
        [self resetEnvironmentURLs];
	}
	
	return self;
}

////////////////////////////////////////////////////////////////////////////////////////////////////
- (void)dealloc {
	
}

#pragma mark -
#pragma mark Properties

////////////////////////////////////////////////////////////////////////////////////////////////////
- (void)setCurrentEnvironment:(ConfigEnvironment)newEnvironment {
    if (newEnvironment != self.currentEnvironment) {
        if (newEnvironment != ConfigEnvironmentProd &&
            newEnvironment != ConfigEnvironmentDev) {
            // If the new environment is invalid, default to prod
            [self setCurrentEnvironment:ConfigEnvironmentProd];
            
            return;
        }
        _currentEnvironment = newEnvironment;
        
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        [defaults setObject:[NSNumber numberWithInt:_currentEnvironment] forKey:kEnvironmentKey];
        [defaults synchronize];
        
        [self resetEnvironmentURLs];
    }
}

////////////////////////////////////////////////////////////////////////////////////////////////////
- (void)resetEnvironmentURLs {
    switch (self.currentEnvironment) {
        case ConfigEnvironmentDev:
            _apiBaseURL = @"http://localhost:3000/";
            break;
            
        default:
            _apiBaseURL = @"http://huskr.herokuapp.com/";
            break;
    }
    
}

@end
