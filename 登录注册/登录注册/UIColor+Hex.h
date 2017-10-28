//
//  UIColor+Hex.h
//  登录注册
//
//  Created by 李慧 on 2017/10/21.
//  Copyright © 2017年 李慧. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (Hex)
+ (UIColor *)colorWithHexValue:(uint)hexValue andAlpha:(float)alpha;
+ (UIColor *)colorWithHexString:(NSString *)hexString andAlpha:(float)alpha;

- (NSString *)hexString;
@end
