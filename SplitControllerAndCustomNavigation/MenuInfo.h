@interface MenuInfo : NSObject 

typedef enum MenuKind {
    ONE, TWO, THREE, FOUR, FIVE, SIX, SEVEN, EIGHT, NINE, TEN
} MenuKind;

@property(nonatomic, retain) NSString *label;
@property(nonatomic, retain) NSString *onImage;
@property(nonatomic, retain) NSString *offImage;
@property(nonatomic, retain) UIViewController *controller;

- (id)initWithLabel:(NSString *)theLabel andOnImage:(NSString *)theOnImage andOffImage:(NSString *)theOffImage andController:(UIViewController *)theController;

@end