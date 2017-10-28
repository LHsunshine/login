//
//  ShareController.h
//  登录注册
//
//  Created by 李慧 on 2017/10/21.
//  Copyright © 2017年 李慧. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ShareController : UIView
@property(nonatomic,strong)UIButton*weixinBtn;
@property(nonatomic,strong)UIButton*QQBtn;
@property(nonatomic,strong)UIButton*weiboBtn;
@property(nonatomic,strong)UIButton*cancelBtn;
@property (strong, nonatomic) UIView *bottomView;

- (instancetype)initWithInitialDate;
@end
