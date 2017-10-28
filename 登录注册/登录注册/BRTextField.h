//
//  BRTextField.h
//  登录注册
//
//  Created by 李慧 on 2017/10/21.
//  Copyright © 2017年 李慧. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^BRTapAcitonBlock)(void);
typedef void(^BREndEditBlock)(NSString *text);

@interface BRTextField : UITextField
/** textField 的点击回调 */
@property (nonatomic, copy) BRTapAcitonBlock tapAcitonBlock;
/** textField 结束编辑的回调 */
@property (nonatomic, copy) BREndEditBlock endEditBlock;
@end
