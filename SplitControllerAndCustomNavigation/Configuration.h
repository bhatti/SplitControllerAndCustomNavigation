//
//  Configuration.h
//  OptionsHouse
//
//  Created by Shahzad Bhatti on 11/29/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface Configuration : NSObject 
-(NSString *) getProperty:(NSString *)name  withDefault:(NSString *)defValue;
-(void) setProperty:(NSString *)name withValue:(NSString *)value;

-(NSArray *) getNavigationOrder;
-(void) setNavigationOrder:(NSArray *)order;

+ (Configuration *)sharedConfiguration;

@end
