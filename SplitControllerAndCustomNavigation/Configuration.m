//
//  Configuration.m
//  OptionsHouse
//
//  Created by Shahzad Bhatti on 11/29/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "Configuration.h"
#import "SynthesizeSingleton.h"

@implementation Configuration

#pragma mark -
#pragma mark Singleton definition

SYNTHESIZE_SINGLETON_FOR_CLASS(Configuration)

-(NSString *) getProperty:(NSString *)name  withDefault:(NSString *)defValue {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *value = [defaults objectForKey:name];
    if (value == nil && defValue != nil) {
        value = defValue;
        //[defaults setObject:defValue forKey:name];
    }
    return value;   
}

-(void) setProperty:(NSString *)name withValue:(NSString *)value {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:value forKey:name];
    [defaults synchronize];
}


-(NSArray *) getNavigationOrder {
    NSString * val = [self getProperty:@"appNavigationOrder" withDefault:@"0,1,2,3,4,5,6,7,8,9"];
    NSCharacterSet *set = [NSCharacterSet characterSetWithCharactersInString:@","];
    return [val componentsSeparatedByCharactersInSet:set];
}

-(void) setNavigationOrder:(NSArray *)order {
    NSMutableString *val = [[[NSMutableString alloc] initWithCapacity:20] autorelease];
    for (NSString *s in order) {
        if ([val length] > 0) {
            [val appendString:@","];
        }
        [val appendString:s];
    }
    [self setProperty:@"appNavigationOrder" withValue:val];
}

@end



