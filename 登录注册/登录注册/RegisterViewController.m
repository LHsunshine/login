//
//  RegisterViewController.m
//  cocoaPodsTest
//
//  Created by 李慧 on 2017/7/4.
//  Copyright © 2017年 李慧. All rights reserved.
//

#import "RegisterViewController.h"
#import "RootTabBarViewController.h"
#import <SVProgressHUD.h>
#import <BmobSDK/Bmob.h>
#import "PrefixHeader.pch"
@interface RegisterViewController ()
{
    UIView *bgView;
    UITextField *phone; // 手机号
    UITextField *code;  // 密码或验证码
     UITextField *UserId; // 学号
    UIButton *registerButton;  // 下一步按钮
}





@end

@implementation RegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //注册按钮
    self.title=@"注册";
    self.navigationController.navigationBarHidden = NO;
    [[UINavigationBar appearance] setBarTintColor:BarTintColor];
    self.view.backgroundColor=BackgroundColor;
    
    // 自定义后退按钮
    UIBarButtonItem *backBtn = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:self action:@selector(clickBackBtn)];
    [backBtn setImage:[UIImage imageNamed:@"goback_orange"]];
    [backBtn setImageInsets:UIEdgeInsetsMake(0, -15, 0, 15)];
    backBtn.tintColor= NavigationColor;
    [self.navigationItem setLeftBarButtonItem:backBtn];
    
    // 手机和验证码输入框
    [self createTextFields];
   
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
#pragma mark - 注册和后退按钮
// 注册按钮
-(void)functionForRegister
{
    
    if ([phone.text isEqualToString:@""])
    {
        [SVProgressHUD showInfoWithStatus:@"亲,请输入注册手机号码"];
        return;
    }
    else if ([self checkTel:phone.text])
    {
        [SVProgressHUD showInfoWithStatus:@"请输入正确的手机号码"];
        return;
    }
    
    if ([code.text isEqualToString:@""])
    {
        [SVProgressHUD showInfoWithStatus:@"亲,请输入密码"];
        return;
    }
    
    // 直接进行注册
    
    //创建一个用户
    BmobUser *bUserRegister = [[BmobUser alloc] init];
    bUserRegister.username = UserId.text;
    bUserRegister.mobilePhoneNumber = phone.text;
    bUserRegister.password = code.text;
    
    
    // 注册
    [bUserRegister signUpInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        if (succeeded)
        {
            //如果注册成功 去主界面
            UIAlertController *alertView=[UIAlertController alertControllerWithTitle:@"提示" message:@"注册成功" preferredStyle:UIAlertControllerStyleAlert]  ;
            
            [alertView addAction:[UIAlertAction actionWithTitle:@"知道了" style:UIAlertActionStyleDefault handler:^(UIAlertAction* _Nonnull action)
                                  {
                                      // 直接进入主界面
                                      [self.navigationController pushViewController:[[RootTabBarViewController alloc]init] animated:YES];
                                  }]];
            
            [self presentViewController:alertView animated:true completion:nil];
        }
        
        else
        {
            NSString *errorString = error.localizedDescription;
            
            NSLog(@"%@",errorString);
            NSLog(@"%@",error);
            UIAlertController *alertView=[UIAlertController alertControllerWithTitle:@"警告" message:errorString preferredStyle:UIAlertControllerStyleAlert]  ;
            
            [alertView addAction:[UIAlertAction actionWithTitle:@"知道了" style:UIAlertActionStyleDefault handler:^(UIAlertAction* _Nonnull action)
                                  {
                                      // 未能注册成功
                                  }]];
            
            [self presentViewController:alertView animated:true completion:nil];
            
            
            
        }
        
    }];
    
}

// 后退按钮
-(void)clickBackBtn
{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - 绘制界面
// 手机和密码输入框
-(void)createTextFields
{
    UILabel *label=[[UILabel alloc]initWithFrame:CGRectMake(30, 75, self.view.frame.size.width-90, 30)];
    label.text=@"请输入您的手机号码";
    label.textColor=labelColor;
    label.textAlignment=LabeltextAlignment;
    label.font=LRFont;
    [self.view addSubview:label];
    
    // 输入框背景框架
    CGRect frame=[UIScreen mainScreen].bounds;
    bgView=[[UIView alloc]initWithFrame:CGRectMake(10, 110, frame.size.width-20, 150)];
    bgView.layer.cornerRadius=bgViewLayer;
    bgView.backgroundColor=bgViewBackgroundColor;
    [self.view addSubview:bgView];
    
    // 手机号
    phone=[self createTextFielfFrame:CGRectMake(100, 10, 200, 30) font:LRFont placeholder:@"11位手机号"];
    phone.clearButtonMode = TextFiledClearButtonMode;
    phone.keyboardType=TextFiledkeyboardType;
    
    UserId=[self createTextFielfFrame:CGRectMake(100, 60, 200, 30) font:LRFont placeholder:@"学号/工号"];
    UserId.clearButtonMode = TextFiledClearButtonMode;
    UserId.keyboardType=TextFiledkeyboardType;
    
    
    
    // 密码
    code=[self createTextFielfFrame:CGRectMake(100, 110, 90, 30) font:LRFont  placeholder:@"6位密码" ];
    code.clearButtonMode = TextFiledClearButtonMode;
    // 密文样式
    code.secureTextEntry=TextFiledsecureTextEntry;
    code.keyboardType=TextFiledkeyboardType;
    
    
    UILabel *phonelabel=[[UILabel alloc]initWithFrame:CGRectMake(20, 12, 50, 25)];
    phonelabel.text=@"手机号";
    phonelabel.textColor=Labelcolor;
    phonelabel.textAlignment=LabeltextAlignment;
    phonelabel.font=LRFont;
    
    UILabel *userlabel=[[UILabel alloc]initWithFrame:CGRectMake(20, 62, 50, 25)];
    userlabel.text=@"学号";
    userlabel.textColor=Labelcolor;
    userlabel.textAlignment=LabeltextAlignment;
    userlabel.font=LRFont;
    
    UILabel *codelabel=[[UILabel alloc]initWithFrame:CGRectMake(20, 112, 50, 25)];
    codelabel.text=@"密码";
    codelabel.textColor=Labelcolor;
    codelabel.textAlignment=LabeltextAlignment;
    codelabel.font=LRFont;
    
    
    UIImageView *line1=[self createImageViewFrame:CGRectMake(20, 50, bgView.frame.size.width-40, 1) imageName:nil color:imageViewColor];
    
    UIImageView *line2=[self createImageViewFrame:CGRectMake(20, 100, bgView.frame.size.width-40, 1) imageName:nil color:imageViewColor];
    
    // 注册按钮
    registerButton=[self createButtonFrame:CGRectMake(10, bgView.frame.size.height+bgView.frame.origin.y+40,self.view.frame.size.width-20, 37) backImageName:nil title:@"注册" titleColor:LRBtnTitleColor  font:RegisterBtnFont target:self action:@selector(functionForRegister)];
    registerButton.backgroundColor=loginRegisterBackgroundColor;
    registerButton.layer.cornerRadius=LRBtnLayerCornerRadius;
    //nextBtn.enabled = FALSE;
    //nextBtn.alpha = 0.3;
    
    [bgView addSubview:phone];
    [bgView addSubview:code];
    [bgView addSubview:UserId];
    
    [bgView addSubview:phonelabel];
    [bgView addSubview:codelabel];
    [bgView addSubview:userlabel];
    [bgView addSubview:line1];
    [bgView addSubview:line2];
    
    [self.view addSubview:registerButton];
    
}



-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [phone resignFirstResponder];
    [code resignFirstResponder];
}

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

#pragma mark - 验证手机号
// 验证手机号
- (BOOL)checkTel:(NSString *)mobileNumbel

{
    /**
     * 移动：134[0-8],135,136,137,138,139,150,151,157,158,159,182,187,188
     * 联通：130,131,132,152,155,156,185,186
     * 电信：133,1349,153,180,189,181(增加)
     */
    NSString * MOBIL = @"^1(3[0-9]|5[0-35-9]|8[025-9])\\d{8}$";
    
    
    NSString * CM = @"^1(34[0-8]|(3[5-9]|5[017-9]|8[2378])\\d)\\d{7}$";
    
    
    NSString * CU = @"^1(3[0-2]|5[256]|8[56])\\d{8}$";
    
    
    
    NSString * CT = @"^1((33|53|8[019])[0-9]|349)\\d{7}$";
    
    
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



@end
