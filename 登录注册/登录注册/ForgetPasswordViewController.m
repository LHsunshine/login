//
//  ForgetPasswordViewController.m
//  cocoaPodsTest
//
//  Created by 李慧 on 2017/7/11.
//  Copyright © 2017年 李慧. All rights reserved.
//

#import "ForgetPasswordViewController.h"
#import "RootTabBarViewController.h"
#import <SVProgressHUD.h>
#import <BmobSDK/Bmob.h>

#import <IQKeyboardManager.h>
#import <IQKeyboardReturnKeyHandler.h>

@interface ForgetPasswordViewController ()
{
    UIView *bgView;     // 手机输入背景
    UITextField *phoneTextField;  // 手机号
    UITextField *smsCodeTextField;  // 验证码
    
    UIView *bgView2;     // 密码输入背景
    UITextField *passwordTextField; // 重置密码框
    UITextField *verifyPasswordTextField;   // 确认重置密码
    
    UIButton *requestSmsCodeButton; // 申请验证码
    UIButton *resetPasswordButton;  // 重置密码
    
    NSTimer *countDownTimer;        // 计时器
    unsigned secondsCountDown;      // 倒计时数
    
    
}

@property (nonatomic, strong) IQKeyboardReturnKeyHandler    *returnKeyHandler;
@property   (nonatomic,strong)  IQKeyboardManager   *manager;


@property UITextField *smsCodeTextField;
@property UITextField *phoneTextField;
@property UIButton *requestSmsCodeButton;
@property UIButton *resetPasswordButton;
@property NSTimer *countDownTimer;
@property unsigned secondsCountDown;
@property UITextField *passwordTextField;
@property UITextField *verifyPasswordTextField;

@end

@implementation ForgetPasswordViewController
@synthesize phoneTextField;
@synthesize smsCodeTextField;
@synthesize requestSmsCodeButton;
@synthesize resetPasswordButton;
@synthesize countDownTimer;
@synthesize secondsCountDown;
@synthesize passwordTextField;
@synthesize verifyPasswordTextField;


- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"重置密码");
    // Do any additional setup after loading the view.
    
    self.navigationController.navigationBarHidden = NO;
    self.title=@"手机号重置密码";
    self.view.backgroundColor=[UIColor colorWithRed:240/255.0f green:240/255.0f blue:240/255.0f alpha:1];
    
    [self constructView];
    [self setViewLogic];
    
    // 返回按钮
    UIBarButtonItem *backButton = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:self action:@selector(functionForBackward)];
    [backButton setImage:[UIImage imageNamed:@"goback_orange"]];
    [backButton setImageInsets:UIEdgeInsetsMake(0, -15, 0, 15)];
    backButton.tintColor=[UIColor colorWithRed:248/255.0f green:144/255.0f blue:34/255.0f alpha:1];
    [self.navigationItem setLeftBarButtonItem:backButton];
    
    // 键盘设置
    self.returnKeyHandler = [[IQKeyboardReturnKeyHandler alloc] initWithViewController:self];
    self.returnKeyHandler.lastTextFieldReturnKeyType = UIReturnKeyDone;
    self.manager.toolbarManageBehaviour = IQAutoToolbarBySubviews;

}
#pragma mark - UI构造
- (void)constructView{
    [self constructBackgroundView]; // 构建手机输入背景
    [self constructPhoneView];      // 构建手机号码输入框
    [self constructSmsCodeView];    // 构建验证码输入框
    [self constructRequestSmsCodeButton];   // 构建获取验证码按钮
    
    [self constructPasswordBackgroundView]; // 构建密码输入背景
    
    [self constructPasswordView];         // 构建密码输入
    [self constructVirifyPasswordView];     // 构建确认密码输入
    [self constructResetPasswordButton];    // 构建重置密码按钮
    [self.resetPasswordButton setEnabled:NO];
    [self.resetPasswordButton setAlpha:0.3];
}

// 构建手机号码输入背景
- (void)constructBackgroundView
{
    // 提示信息
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(30, 75, self.view.frame.size.width-90, 30)];
    label.text = @"请输入您的手机号码，点击获取验证码";
    label.textColor = [UIColor grayColor];
    label.textAlignment = NSTextAlignmentLeft;
    label.font = [UIFont systemFontOfSize:13];
    [self.view addSubview:label];
    
    // 输入背景
    CGRect frame=[UIScreen mainScreen].bounds;
    bgView=[[UIView alloc]initWithFrame:CGRectMake(10, 110, frame.size.width-20, 100)];
    bgView.layer.cornerRadius=3.0;
    bgView.backgroundColor=[UIColor whiteColor];
    [self.view addSubview:bgView];
    
    UIImageView *line=[self createImageViewFrame:CGRectMake(20, 50, bgView.frame.size.width-40, 1) imageName:nil color:[UIColor colorWithRed:180/255.0f green:180/255.0f blue:180/255.0f alpha:.3]];
    [bgView addSubview:line];
}
// 构建手机号码输入框
- (void)constructPhoneView
{
    
    // 手机号：
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(20, 12, 50, 25)];
    label.text = @"手机号:";
    label.textAlignment = NSTextAlignmentLeft;
    label.font=[UIFont systemFontOfSize:14];
    [bgView addSubview:label];
    
    // 手机号输入框
    self.phoneTextField = [self createTextFielfFrame:CGRectMake(100, 10, 200, 30) font:[UIFont systemFontOfSize:14] placeholder:@"11位手机号"];
    self.phoneTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
    self.phoneTextField.keyboardType = UIKeyboardTypeNumberPad;
    [bgView addSubview:self.phoneTextField];
    
}
// 构建验证码输入框
- (void)constructSmsCodeView
{
    // 验证码:
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(20, 62, 50, 25)];
    label.text = @"验证码:";
    label.textAlignment = NSTextAlignmentLeft;
    label.font=[UIFont systemFontOfSize:14];
    [bgView addSubview:label];
    
    // 验证码输入框
    self.smsCodeTextField = [self createTextFielfFrame:CGRectMake(100, 60, 90, 30) font:[UIFont systemFontOfSize:14]  placeholder:@"6位验证码" ];
    self.smsCodeTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
    self.smsCodeTextField.secureTextEntry = NO;
    self.smsCodeTextField.keyboardType=UIKeyboardTypeNumberPad;
    [bgView addSubview:self.smsCodeTextField];
    
}
// 构建获取验证码按钮
-(void)constructRequestSmsCodeButton{
    self.requestSmsCodeButton = [[UIButton alloc] initWithFrame:CGRectMake(bgView.frame.size.width-100-20, 62, 100, 30)];
    self.requestSmsCodeButton.layer.cornerRadius = 3;
    
    [self.requestSmsCodeButton setTitle:@"获取验证码" forState:UIControlStateNormal];
    [self.requestSmsCodeButton setTitleColor:[UIColor colorWithRed:248/255.0f green:144/255.0f blue:34/255.0f alpha:1] forState:UIControlStateNormal];
    self.requestSmsCodeButton.backgroundColor = [UIColor colorWithRed:240/255.0f green:240/255.0f blue:240/255.0f alpha:1];
    [bgView addSubview:self.requestSmsCodeButton];
    
}


// 构建重置密码输入背景
- (void)constructPasswordBackgroundView
{
    // 提示信息
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(30, 230, self.view.frame.size.width-90, 30)];
    label.text = @"请输入新密码";
    label.textColor = [UIColor grayColor];
    label.textAlignment = NSTextAlignmentLeft;
    label.font = [UIFont systemFontOfSize:13];
    [self.view addSubview:label];
    
    // 输入背景
    CGRect frame=[UIScreen mainScreen].bounds;
    bgView2 = [[UIView alloc]initWithFrame:CGRectMake(10, 270, frame.size.width-20, 100)];
    bgView2.layer.cornerRadius=3.0;
    bgView2.backgroundColor=[UIColor whiteColor];
    [self.view addSubview:bgView2];
    
    UIImageView *line=[self createImageViewFrame:CGRectMake(20, 50, bgView.frame.size.width-40, 1) imageName:nil color:[UIColor colorWithRed:180/255.0f green:180/255.0f blue:180/255.0f alpha:.3]];
    [bgView2 addSubview:line];
}
// 构建密码输入
-(void)constructPasswordView{
    
    // 密码：
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(20, 12, 50, 25)];
    label.text = @"密码:";
    label.textAlignment = NSTextAlignmentLeft;
    label.font=[UIFont systemFontOfSize:14];
    [bgView2 addSubview:label];
    
    // 密码输入框
    self.passwordTextField = [self createTextFielfFrame:CGRectMake(100, 10, 200, 30) font:[UIFont systemFontOfSize:14] placeholder:@"请输入6位密码"];
    self.passwordTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
    self.passwordTextField.keyboardType = UIKeyboardTypeNumberPad;
    self.passwordTextField.secureTextEntry = YES;
    [bgView2 addSubview:self.passwordTextField];
    
}
// 构建确认密码输入
- (void)constructVirifyPasswordView
{
    // 密码:
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(20, 62, 80, 25)];
    label.text = @"确认密码:";
    label.textAlignment = NSTextAlignmentLeft;
    label.font=[UIFont systemFontOfSize:14];
    [bgView2 addSubview:label];
    
    // 确认密码输入框
    self.verifyPasswordTextField = [self createTextFielfFrame:CGRectMake(100, 60, 200, 30) font:[UIFont systemFontOfSize:14]  placeholder:@"请再次输入密码" ];
    self.verifyPasswordTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
    self.verifyPasswordTextField.secureTextEntry = NO;
    self.verifyPasswordTextField.keyboardType=UIKeyboardTypeNumberPad;
    self.verifyPasswordTextField.secureTextEntry = YES;
    [bgView2 addSubview:self.verifyPasswordTextField];
    
}
// 构建重置密码按钮
-(void)constructResetPasswordButton{
    self.resetPasswordButton = [self createButtonFrame:CGRectMake(10, bgView2.frame.size.height + bgView2.frame.origin.y + 30,self.view.frame.size.width-20, 37) backImageName:nil title:@"重设密码" titleColor:[UIColor whiteColor]  font:[UIFont systemFontOfSize:17] target:self action:@selector(setResetPasswordBtnLogic)];
    
    self.resetPasswordButton.layer.cornerRadius = 5;
    
    self.resetPasswordButton.backgroundColor = [UIColor colorWithRed:248/255.0f green:144/255.0f blue:34/255.0f alpha:1];
    [self.view addSubview:self.resetPasswordButton];
}



# pragma mark - 逻辑
- (void)setViewLogic
{
    [self.resetPasswordButton addTarget:self action:@selector(setResetPasswordBtnLogic) forControlEvents:UIControlEventTouchUpInside];
    [self.requestSmsCodeButton addTarget:self action:@selector(setRequestSmsCodeBtnLogic) forControlEvents:UIControlEventTouchUpInside];
}

-(void)setRequestSmsCodeBtnLogic{
    if ([self.phoneTextField.text isEqualToString:@""])
    {
        [SVProgressHUD showInfoWithStatus:@"亲,请输入手机号码"];
        return;
    }
    else if ([self checkTel:self.phoneTextField.text])
    {
        [SVProgressHUD showInfoWithStatus:@"请输入正确的手机号码"];
        return;
    }
    //请求验证码
    [BmobSMS requestSMSCodeInBackgroundWithPhoneNumber:self.phoneTextField.text andTemplate:@"account" resultBlock:^(int number, NSError *error)
     {
         if (error) {
             NSLog(@"%@",error);
         } else {
             // 获得smsID
             NSLog(@"sms ID：%d",number);
             // 设置不可点击
             [self setRequestSmsCodeBtnCountDown];
             
         }
     }];
    // 重置按钮可用
    [self.resetPasswordButton setEnabled:YES];
    [self.resetPasswordButton setAlpha:1];
}

-(void)setResetPasswordBtnLogic{
    NSString *smsCode = self.smsCodeTextField.text;
    NSString *password = self.passwordTextField.text;
    NSString *verifyPassword = self.verifyPasswordTextField.text;
    if (!smsCode || [smsCode isEqualToString:@""] || !password || [password isEqualToString:@""] || !verifyPassword || [verifyPassword isEqualToString:@""] || ![password isEqualToString:verifyPassword])
    {
        UIAlertController *tip=[UIAlertController alertControllerWithTitle:@"警告" message:@"验证码不能为空，密码及确认密码必须相等且不为空" preferredStyle:UIAlertControllerStyleAlert]  ;
        
        [tip addAction:[UIAlertAction actionWithTitle:@"知道了" style:UIAlertActionStyleDefault handler:^(UIAlertAction* _Nonnull action)
                        {
                            
                        }]];
        [self presentViewController:tip animated:true completion:nil];
        
    } else {
        [BmobUser resetPasswordInbackgroundWithSMSCode:smsCode andNewPassword:password block:^(BOOL isSuccessful, NSError *error) {
            if (isSuccessful) {
                
                UIAlertController *tip=[UIAlertController alertControllerWithTitle:@"恭喜" message:@"重置密码成功，开始购物吧" preferredStyle:UIAlertControllerStyleAlert]  ;
                
                [tip addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction* _Nonnull action)
                                {
                                    //跳转
                                    RootTabBarViewController *main = [[RootTabBarViewController alloc] init];
                                    [self.navigationController pushViewController:main animated:YES];
                                }]];
                [self presentViewController:tip animated:true completion:nil];
                
                
            } else {
                UIAlertController *tip=[UIAlertController alertControllerWithTitle:@"错误" message:@"验证码有误" preferredStyle:UIAlertControllerStyleAlert]  ;
                
                [tip addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction* _Nonnull action)
                                {
                                    
                                }]];
                [self presentViewController:tip animated:true completion:nil];
            }
        }];
    }
}


#pragma mark - 验证手机号
// 验证手机号
- (BOOL)checkTel:(NSString *)mobileNumbel
{
    /**
     * 移动：134[0-8],135,136,137,138,139,150,151,157,158,159,182,187,188
     * 联通：130,131,132,152,155,156,185,186
     * 电信：133,153,180,189,181，177(增加)
     */
    NSString * MOBIL = @"^1(3[0-9]|5[0-35-9]|8[025-9])\\d{8}$";
    
    
    NSString * CM = @"^1(34[0-8]|(3[5-9]|5[017-9]|8[2378])\\d)\\d{7}$";
    
    
    NSString * CU = @"^1(3[0-2]|5[256]|8[56])\\d{8}$";
    
    
    
    NSString * CT = @"^1((33|53|77|8[019])[0-9]|349)\\d{7}$";
    
    
    NSPredicate *regextestmobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", MOBIL];
    NSPredicate *regextestcm = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CM];
    NSPredicate *regextestcu = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CU];
    NSPredicate *regextestct = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CT];
    
    if (([regextestmobile evaluateWithObject:mobileNumbel]
         || [regextestcm evaluateWithObject:mobileNumbel]
         || [regextestct evaluateWithObject:mobileNumbel]
         || [regextestcu evaluateWithObject:mobileNumbel])) {
        NSLog(@"手机号验证可用");
        return NO;
    }
    
    return YES;
}
#pragma mark - 获取验证码的计时器
-(void)setRequestSmsCodeBtnCountDown{
    [self.requestSmsCodeButton setEnabled:NO];
    self.requestSmsCodeButton.backgroundColor = [UIColor grayColor];
    self.secondsCountDown = 60;
    
    countDownTimer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(countDownTimeWithSeconds:) userInfo:nil repeats:YES];
    [countDownTimer fire];
}
-(void)countDownTimeWithSeconds:(NSTimer*)timerInfo{
    if (secondsCountDown == 0) {
        [self.requestSmsCodeButton setEnabled:YES];
        self.requestSmsCodeButton.backgroundColor = [UIColor redColor];
        [self.requestSmsCodeButton setTitle:@"获取验证码" forState:UIControlStateNormal];
        [countDownTimer invalidate];
    } else {
        [self.requestSmsCodeButton setTitle:[[NSNumber numberWithInt:secondsCountDown] description] forState:UIControlStateNormal];
        self.secondsCountDown--;
    }
}


-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.phoneTextField resignFirstResponder];
    [self.smsCodeTextField resignFirstResponder];
    [self.passwordTextField resignFirstResponder];
    [self.verifyPasswordTextField resignFirstResponder];
}

#pragma mark - 绘制frame
-(UITextField *)createTextFielfFrame:(CGRect)frame font:(UIFont *)font placeholder:(NSString *)placeholder
{
    UITextField *textField=[[UITextField alloc]initWithFrame:frame];
    
    textField.font=font;
    
    textField.textColor=[UIColor grayColor];
    
    textField.borderStyle=UITextBorderStyleNone;
    
    textField.placeholder=placeholder;
    
    return textField;
}

-(UIImageView *)createImageViewFrame:(CGRect)frame imageName:(NSString *)imageName color:(UIColor *)color
{
    UIImageView *imageView=[[UIImageView alloc]initWithFrame:frame];
    
    if (imageName)
    {
        imageView.image=[UIImage imageNamed:imageName];
    }
    if (color)
    {
        imageView.backgroundColor=color;
    }
    
    return imageView;
}

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



-(void)functionForBackward
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/



@end
