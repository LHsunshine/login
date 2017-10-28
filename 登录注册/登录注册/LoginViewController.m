//
//  LoginViewController.m
//  cocoaPodsTest
//
//  Created by 李慧 on 2017/7/4.
//  Copyright © 2017年 李慧. All rights reserved.
//

#import "LoginViewController.h"
#import "AppDelegate.h"
#import "ViewController.h"
#import "MyTableViewController.h"
#import "RootTabBarViewController.h"
#import "MyTableViewController.h"
#import "RegisterViewController.h"
#import "ForgetPasswordViewController.h"
#import <BmobSDK/Bmob.h>
#import <SVProgressHUD.h>
#import "PrefixHeader.pch"
@interface LoginViewController ()
{
    UIImageView *bgImageView; // 登录页面背景图
    UIView *bgView;         // 整体输入框
    UITextField *pwd;       // 密码
    UITextField *user;      // 用户名
    UIButton *QQBtn;        // QQ登录
    UIButton *weixinBtn;    // 微信登录
    UIButton *sinaBtn;      // 新浪登录
}



@end

@implementation LoginViewController
-(void)viewWillAppear:(BOOL)animated
{
    // 登录界面先隐藏导航栏
    self.navigationController.navigationBarHidden = YES;
       

    
}
- (void)viewWillDisappear:(BOOL)animated{
    //如果不想隐藏其他页面的导航栏 需要重置
    self.navigationController.navigationBarHidden = NO;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
        //登录按钮
    
    [BmobUser logout];
    NSLog(@"tuichu");
    
    
    // 如果用户已经登录并认证，直接进入主页，没有动画
    BmobUser *currentUser = [BmobUser currentUser];
    
    if (currentUser)
    {
        NSLog(@"目前用户是%@",currentUser);
        
        [self.navigationController pushViewController:[[RootTabBarViewController alloc]init] animated:YES];
    }
    else
    {
        // 背景图，全屏适配
        bgImageView=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
        bgImageView.image=LoginBackgroundColor;    // 背景图片
        [self.view addSubview:bgImageView];
        

        // 导航栏注册按钮，registration：
        UIButton *buttonRegister =[[UIButton alloc]initWithFrame:CGRectMake(self.view.frame.size.width-60, 30, 50, 30)];
        [buttonRegister setTitle:@"注册" forState:UIControlStateNormal];
        [buttonRegister setTitleColor: NavigationColor forState:UIControlStateNormal];
        buttonRegister.titleLabel.font = buttonRegisterTitleLabelFont;
        [buttonRegister addTarget:self action:@selector(registration:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:buttonRegister];
        
        // 导航栏标题
        UILabel *label=[[UILabel alloc]initWithFrame:CGRectMake((self.view.frame.size.width-30)/2, 30, 50, 30)];
        label.text=@"登录";
        label.textColor=NavigationColor;
        [self.view addSubview:label];
        
        
        [self createButtons];   // 绘制6个按钮
        
        [self createTextFields];    // 用户密码输入框
        
        [self createLabel]; // @"第三方账号快速登录"
        [self createImageViews];    // 左右的横线
        
   
}
}



#pragma mark - 绘制界面
// 6个按钮
- (void)createButtons
{
    // 登录按钮，loginClick
    UIButton *loginBtn = [self createButtonFrame:CGRectMake(10, 250, self.view.frame.size.width-20, 37) backImageName:nil title:@"登录" titleColor:LRBtnTitleColor  font:LRFont target:self action:@selector(loginClick)];
    loginBtn.backgroundColor = loginRegisterBackgroundColor;
    loginBtn.layer.cornerRadius = LRBtnLayerCornerRadius;
    
    // 快速注册按钮，registration
    UIButton *newUserBtn = [self createButtonFrame:CGRectMake(5, 300, 70, 30) backImageName:nil title:@"快速注册" titleColor:BtnTitleColor font:LRFont  target:self action:@selector(registration:)];
    // 找回密码，fogetPwd
    UIButton *forgotPwdBtn=[self createButtonFrame:CGRectMake(self.view.frame.size.width-75, 300, 60, 30) backImageName:nil title:@"找回密码" titleColor:BtnTitleColor font:LRFont          target:self action:@selector(fogetPwd:)];
    
    
//#define Start_X 60.0f           // 第一个按钮的X坐标
//#define Start_Y 440.0f           // 第一个按钮的Y坐标
//#define Width_Space 50.0f        // 2个按钮之间的横间距
//#define Height_Space 20.0f      // 竖间距
//#define Button_Height 50.0f    // 高
//#define Button_Width 50.0f      // 宽
    
    
    
    //微信
    weixinBtn=[[UIButton alloc]initWithFrame:CGRectMake((self.view.frame.size.width-50)/2, 440, 50, 50)];
    //weixinBtn.tag = UMSocialSnsTypeWechatSession;
    weixinBtn.layer.cornerRadius=BtnLayer;
    weixinBtn=[self createButtonFrame:weixinBtn.frame backImageName:@"ic_login_wechat" title:nil titleColor:nil font:nil target:self action:@selector(onClickWX:)];
    
    //QQ
    QQBtn=[[UIButton alloc]initWithFrame:CGRectMake((self.view.frame.size.width-50)/2-100, 440, 50, 50)];
    //QQBtn.tag = UMSocialSnsTypeMobileQQ;
    QQBtn.layer.cornerRadius=BtnLayer;
    QQBtn=[self createButtonFrame:QQBtn.frame backImageName:@"ic_login_qq" title:nil titleColor:nil font:nil target:self action:@selector(onClickQQ:)];
    
    //新浪微博
    sinaBtn=[[UIButton alloc]initWithFrame:CGRectMake((self.view.frame.size.width-50)/2+100, 440, 50, 50)];
    //xinlangBtn.tag = UMSocialSnsTypeSina;
    sinaBtn.layer.cornerRadius=BtnLayer;
    sinaBtn=[self createButtonFrame:sinaBtn.frame backImageName:@"ic_login_sina" title:nil titleColor:nil font:nil target:self action:@selector(onClickSina:)];
    
    [self.view addSubview:weixinBtn];
    [self.view addSubview:QQBtn];
    [self.view addSubview:sinaBtn];
    [self.view addSubview:loginBtn];
    [self.view addSubview:newUserBtn];
    [self.view addSubview:forgotPwdBtn];
}

// 左右的横线
-(void)createImageViews
{
    
    UIImageView *lineLeft=[self createImageViewFrame:CGRectMake(2, 400, 100, 1) imageName:nil color:lineColor];
    UIImageView *lineRight=[self createImageViewFrame:CGRectMake(self.view.frame.size.width-100-4, 400, 100, 1) imageName:nil color:lineColor];
    
    [self.view addSubview:lineLeft];
    [self.view addSubview:lineRight];
    
}

// @"第三方账号快速登录"
- (void)createLabel
{
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake((self.view.frame.size.width-140)/2, 390, 140, 21)];
    label.text = @"第三方账号快速登录";
    label.textColor = labelColor;
    label.textAlignment = labelTextAlignment;
    label.font = LRLabelFont;
    [self.view addSubview:label];
}

// 用户密码输入框
-(void)createTextFields
{
    CGRect frame = [UIScreen mainScreen].bounds;
    
    // 输入框
    bgView = [[UIView alloc]initWithFrame:CGRectMake(10, 110, frame.size.width-20, 120)];
    bgView.layer.cornerRadius = bgViewLayer;
    bgView.alpha = bgViewAlpha;
    bgView.backgroundColor = bgViewBackgroundColor;
    [self.view addSubview:bgView];
    
    // 用户名框，调用createTextFielfFrame
    user = [self createTextFielfFrame:CGRectMake(60, 25, 271, 30) font:LRFont placeholder:@"请输入您手机号码或工号"];
    user.text=@"13260547600";
    user.keyboardType = TextFiledkeyboardType;
    user.clearButtonMode = TextFiledClearButtonMode;
    
    // 密码框，调用createTextFielfFrame
    pwd = [self createTextFielfFrame:CGRectMake(60, 75, 271, 30) font:LRFont placeholder:@"密码" ];
    pwd.text = @"111111";
    pwd.keyboardType = TextFiledkeyboardType;
    pwd.clearButtonMode = TextFiledClearButtonMode;
    //密文样式
    pwd.secureTextEntry=TextFiledsecureTextEntry;
    
    // 用户图标，横线，密码图标
    UIImageView *userImageView=[self createImageViewFrame:CGRectMake(20, 25, 25, 25) imageName:@"ic_login_nickname" color:nil];
    UIImageView *pwdImageView=[self createImageViewFrame:CGRectMake(20, 75, 25, 25) imageName:@"ic_login_password" color:nil];
    UIImageView *line1=[self createImageViewFrame:CGRectMake(20, 65, bgView.frame.size.width-40, 1) imageName:nil color:imageViewColor];
    
    [bgView addSubview:user];
    [bgView addSubview:pwd];
    
    [bgView addSubview:userImageView];
    [bgView addSubview:pwdImageView];
    [bgView addSubview:line1];
}

#pragma mark - 绘制frame的方法
// 绘制imageView的通用方法
-(UIImageView *)createImageViewFrame:(CGRect)frame imageName:(NSString *)imageName color:(UIColor *)color
{
    UIImageView *imgName=[[UIImageView alloc]initWithFrame:frame];
    
    if (imageName)
    {
        imgName.image=[UIImage imageNamed:imageName];
    }
    if (color)
    {
        imgName.backgroundColor = color;
    }
    
    return imgName;
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

// 绘制textField
- (UITextField *)createTextFielfFrame:(CGRect)frame font:(UIFont *)font placeholder:(NSString *)placeholder
{
    UITextField *textField = [[UITextField alloc]initWithFrame:frame];
    
    textField.font = font;
    
    textField.textColor = [UIColor grayColor];
    
    textField.borderStyle = UITextBorderStyleNone;
    
    textField.placeholder = placeholder;
    
    return textField;
}



-(void)touchesEnded:(nonnull NSSet<UITouch *> *)touches withEvent:(nullable UIEvent *)event
{
    [user resignFirstResponder];
    [pwd resignFirstResponder];
}


-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [user resignFirstResponder];
    [pwd resignFirstResponder];
}

#pragma mark - 第三方登录的方法
- (void)onClickQQ:(UIButton *)button
{
}

- (void)onClickWX:(UIButton *)button
{
}


- (void)onClickSina:(UIButton *)button
{
    
}


#pragma mark - 登录注册按钮的方法
//登录
-(void)loginClick
{
    if ([user.text isEqualToString:@""])
    {
        [SVProgressHUD showInfoWithStatus:@"亲,请输入用户名"];
        return;
    }
    else if (user.text.length < 11)
    {
        [SVProgressHUD showInfoWithStatus:@"您输入的手机号码格式不正确"];
        return;
    }
    else if ([pwd.text isEqualToString:@""])
    {
        [SVProgressHUD showInfoWithStatus:@"亲,请输入密码"];
        return;
    }
    else if (pwd.text.length < 6)
    {
        [SVProgressHUD showInfoWithStatus:@"亲,密码长度至少六位"];
        return;
    }
    
    [BmobUser loginInbackgroundWithAccount:user.text andPassword:pwd.text block:^(BmobUser *bUserLogin, NSError *error)
     {
         
         //有用户
         if (bUserLogin)
         {
             //登陆成功,去主界面
             NSLog(@"登录成功");
             [self.navigationController pushViewController:[[RootTabBarViewController alloc]init] animated:YES];
         }
         
         else
         {
             NSLog(@"登录失败");
             // [SVProgressHUD showInfoWithStatus:@"帐号不存在 或 密码错误"];
             UIAlertController *alertView=[UIAlertController alertControllerWithTitle:@"警告" message:@"帐号不存在 或 密码错误" preferredStyle:UIAlertControllerStyleAlert]  ;
             
             [alertView addAction:[UIAlertAction actionWithTitle:@"知道了" style:UIAlertActionStyleDefault handler:^(UIAlertAction* _Nonnull action)
                                   {
                                       
                                   }]];
             
             [self presentViewController:alertView animated:true completion:nil];
         }
     }];
    
}

// 注册按钮
-(void)registration:(UIButton *)button
{
    [self.navigationController pushViewController:[[RegisterViewController alloc]init] animated:YES];
}

// 忘记密码按钮
-(void)fogetPwd:(UIButton *)button
{
    [self.navigationController pushViewController:[[ForgetPasswordViewController alloc]init] animated:YES];
}

#pragma mark - 工具
//手机号格式化
-(NSString*)getHiddenStringWithPhoneNumber:(NSString*)number middle:(NSInteger)countHiiden{
    // if (number.length>6) {
    
    if (number.length<countHiiden) {
        return number;
    }
    NSInteger count=countHiiden;
    NSInteger leftCount=number.length/2-count/2;
    NSString *xings=@"";
    for (int i=0; i<count; i++) {
        xings=[NSString stringWithFormat:@"%@%@",xings,@"*"];
    }
    
    NSString *chuLi=[number stringByReplacingCharactersInRange:NSMakeRange(leftCount, count) withString:xings];
    // chuLi=[chuLi stringByReplacingCharactersInRange:NSMakeRange(number.length-count, count-leftCount) withString:xings];
    
    return chuLi;
}

// 手机号格式化后还原
- (NSString*)getHiddenStringWithPhoneNumber1:(NSString*)number middle:(NSInteger)countHiiden{
    // if (number.length>6) {
    if (number.length < countHiiden) {
        return number;
    }
    //NSString *xings=@"";
    for (int i=0; i<1; i++) {
        //xings=[NSString stringWithFormat:@"%@",[CheckTools getUser]];
    }
    
    NSString *chuLi=[number stringByReplacingCharactersInRange:NSMakeRange(0, 0) withString:@""];
    // chuLi=[chuLi stringByReplacingCharactersInRange:NSMakeRange(number.length-count, count-leftCount) withString:xings];
    
    return chuLi;
}




@end
