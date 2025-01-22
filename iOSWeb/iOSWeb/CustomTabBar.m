#import "CustomTabBar.h"

@implementation CustomTabBar

- (CGSize)sizeThatFits:(CGSize)size {
    CGSize newSize = [super sizeThatFits:size];
    newSize.height = 44.0; // 设置您想要的高度
    return newSize;
}

@end 
