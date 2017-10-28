//
//  FirstViewController.m
//  登录注册
//
//  Created by 李慧 on 2017/10/20.
//  Copyright © 2017年 李慧. All rights reserved.
//

#import "FirstViewController.h"

@interface FirstViewController ()

@end

@implementation FirstViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //设置导航栏的背景颜色
    self.navigationController.navigationBar.barTintColor=[UIColor orangeColor];
    [self.navigationController.navigationBar setTranslucent:NO];
    //设置导航栏字体颜色
    [self.navigationController.navigationBar setTitleTextAttributes:
     @{NSFontAttributeName:[UIFont systemFontOfSize:19],
       NSForegroundColorAttributeName:[UIColor whiteColor]}];

    self.view.backgroundColor=[UIColor colorWithRed:255/255.0 green:219/255.0 blue:200/255.0 alpha:1];
    // Do any additional setup after loading the view.
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
