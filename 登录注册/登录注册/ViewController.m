//
//  ViewController.m
//  登录注册
//
//  Created by 李慧 on 2017/8/2.
//  Copyright © 2017年 李慧. All rights reserved.
//

#import "ViewController.h"
#import "LoginViewController.h"
#import "RegisterViewController.h"
#import <BmobSDK/Bmob.h>
#import <BmobSDK/BmobUser.h>

@interface ViewController ()
{
    UIImageView *bgImageView; // 页面背景图
}
@end

@implementation ViewController
-(void)viewWillAppear:(BOOL)animated
{
    // 登录界面先隐藏导航栏
    self.navigationController.navigationBarHidden = YES;
//    BmobUser *bUser = [BmobUser currentUser];
//    if (bUser) {
//        // 直接进入主界面
//        NSLog(@"直接进入主界面");
//        NSLog(@"%@",bUser);
//
//        [self performSegueWithIdentifier:@"send" sender:nil];
//        //        RootTabBarViewController* rootTabBarViewController;
//        //       [self showViewController:rootTabBarViewController sender:nil];
//
//    }
//    //    else{
//    //        //对象为空时，可打开用户注册界面
//    //    }
//
}
- (void)viewWillDisappear:(BOOL)animated{
    //如果不想隐藏其他页面的导航栏 需要重置
    self.navigationController.navigationBarHidden = NO;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // 背景图，全屏适配
    bgImageView=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    bgImageView.image=[UIImage imageNamed:@"bgImage"];    // 背景图片
    [self.view addSubview:bgImageView];
    
    // 快速注册按钮，registration
    
    UIButton *loginBut = [self createButtonFrame:CGRectMake(30, self.view.frame.size.height/2+200, 120, 50) backImageName:nil title:@"登录" titleColor:[UIColor whiteColor] font:[UIFont systemFontOfSize:20] target:self action:@selector(loginBut:)];
    loginBut.backgroundColor=[UIColor colorWithRed:111/255.0 green:113/255.0 blue:121/255.0 alpha:0.5];
    
    // 找回密码，fogetPwd
    UIButton *registerBut=[self createButtonFrame:CGRectMake(self.view.frame.size.width-150, self.view.frame.size.height/2+200, 120, 50) backImageName:nil title:@"新用户" titleColor:[UIColor whiteColor] font:[UIFont systemFontOfSize:20] target:self action:@selector(registerBut:)];
    registerBut.backgroundColor=[UIColor colorWithRed:0/255.0 green:122/255.0 blue:255/255.0 alpha:0.5];
    
    [self.view addSubview:loginBut];
    [self.view addSubview:registerBut];
    
}

// 注册按钮
-(void)loginBut:(UIButton *)button
{
    [self.navigationController pushViewController:[[LoginViewController alloc]init] animated:YES];
}

// 忘记密码按钮
-(void)registerBut:(UIButton *)button
{
    [self.navigationController pushViewController:[[RegisterViewController alloc]init] animated:YES];
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


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
