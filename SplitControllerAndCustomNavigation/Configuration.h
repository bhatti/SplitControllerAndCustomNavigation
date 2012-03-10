#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface Configuration : NSObject 
-(NSString *) getProperty:(NSString *)name  withDefault:(NSString *)defValue;
-(void) setProperty:(NSString *)name withValue:(NSString *)value;

-(NSArray *) getNavigationOrder;
-(void) setNavigationOrder:(NSArray *)order;

+ (Configuration *)sharedConfiguration;

@end
