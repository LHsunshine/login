//
//  ShareController.m
//  登录注册
//
//  Created by 李慧 on 2017/10/21.
//  Copyright © 2017年 李慧. All rights reserved.
//

#import "ShareController.h"
#define kScreenWidth [UIScreen mainScreen].bounds.size.width
#define kScreenHeight [UIScreen mainScreen].bounds.size.height
@implementation ShareController
-(instancetype)initWithInitialDate{
    if ([super init]) {
        self.frame=CGRectMake(0, 0, kScreenWidth, kScreenHeight);
        self.backgroundColor=[[UIColor darkGrayColor]colorWithAlphaComponent:0.618];
        [self drawView];
        self.bottomView.frame = CGRectMake(0, kScreenHeight, kScreenWidth, 216 + 44);
        [UIView animateWithDuration:0.25 animations:^{
            
            self.bottomView.frame = CGRectMake(0, kScreenHeight - 216 - 44 - 64, kScreenWidth, 216 + 44);
            [self.bottomView layoutIfNeeded];
        }];
    }
    return self;
}
-(void)drawView{
    [self addSubview:self.bottomView];
}
#pragma mark - 懒加载
-(UIButton *)QQBtn{
    if (!_QQBtn) {
        self.QQBtn=[self createButtonFrame:CGRectMake(30, 60, 80, 80) backImageName:@"ic_login_qq" title:nil titleColor:nil font:nil target:self action:@selector(QQBtn:)];
    }
    return _QQBtn;
}
-(UIButton *)weixinBtn{
    if (!_weixinBtn) {
        self.weixinBtn=[self createButtonFrame:CGRectMake(150, 60, 80, 80) backImageName:@"ic_login_wechat" title:nil titleColor:nil font:nil target:self action:@selector(weixinBtn:)];
    }
    return _weixinBtn;
    
}
-(UIButton *)weiboBtn{
    if (!_weiboBtn) {
        self.weiboBtn=[self createButtonFrame:CGRectMake(260, 60, 80, 80) backImageName:@"ic_login_sina" title:nil titleColor:nil font:nil target:self action:@selector(weiboBtn:)];
    }
    return _weiboBtn;
    
}
-(UIButton *)cancelBtn{
    if (!_cancelBtn) {
        _cancelBtn=[[UIButton alloc]init];
        _cancelBtn=[self createButtonFrame:CGRectMake(kScreenWidth-44-20, 12, 44, 20) backImageName:nil title:@"取消" titleColor:[UIColor redColor] font:[UIFont systemFontOfSize:15] target:self action:@selector(cancenBtnAction:)];
    }
    return _cancelBtn;
}
- (UIView *)bottomView {
    
    if (!_bottomView) {
        
        _bottomView = [[UIView alloc] init];
        _bottomView.backgroundColor = [UIColor whiteColor];
        
        [_bottomView addSubview:self.QQBtn];
        [_bottomView addSubview:self.weiboBtn];
        [_bottomView addSubview:self.weixinBtn];
        [_bottomView addSubview:self.cancelBtn];
    }
    
    return _bottomView;
}
-(void)QQBtn:(id)sender{
    
}
-(void)weixinBtn:(id)sender{
    
}

-(void)weiboBtn:(id)sender{
    
}
-(void)cancenBtnAction:(id)sender{
    self.bottomView.frame = CGRectMake(0, kScreenHeight - 216 - 44 - 64, kScreenWidth, 216 + 44);
    [UIView animateWithDuration:0.25 animations:^{
        
        self.bottomView.frame = CGRectMake(0, kScreenHeight, kScreenWidth, 216 + 44);
        [self.bottomView layoutIfNeeded];
        
        self.backgroundColor = [[UIColor darkGrayColor] colorWithAlphaComponent:0];
    } completion:^(BOOL finished) {
        
        [self removeFromSuperview];
    }];
    
}
//绘制label的通用方法
-(UILabel*)createLabelFrame:(CGRect)frame text:(NSString*)text textcolor:(UIColor*)color font:(UIFont*)font{
    UILabel*label=[[UILabel alloc]init];
    label.frame=frame;
    if (text) {
        label.text=text;
    }
    if (color) {
        label.textColor=color;
    }
    if (font) {
        label.font=font;
    }
    return label;
}
// 绘制按钮的通用方法
-(UIButton *)createButtonFrame:(CGRect)frame backImageName:(NSString *)imageName title:(NSString *)title titleColor:(UIColor *)color font:(UIFont *)font target:(id)target action:(SEL)action
{
    UIButton *btn=[UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame=frame;
    if (imageName)
    {
        [btn setBackgroundImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    }
    
    if (font)
    {
        btn.titleLabel.font=font;
    }
    
    if (title)
    {
        [btn setTitle:title forState:UIControlStateNormal];
    }
    if (color)
    {
        [btn setTitleColor:color forState:UIControlStateNormal];
    }
    if (target&&action)
    {
        [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    }
    return btn;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
