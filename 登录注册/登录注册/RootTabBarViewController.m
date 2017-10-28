//
//  RootTabBarViewController.m
//  cocoaPodsTest
//
//  Created by 李慧 on 2017/7/6.
//  Copyright © 2017年 李慧. All rights reserved.
//

#import "RootTabBarViewController.h"
#import "UIColor+Hex.h"
#import "FirstViewController.h"
#import "MyTableViewController.h"
@interface RootTabBarViewController ()

@end

@implementation RootTabBarViewController
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
    NSArray *titles = @[@"首页",@"我的"];
    NSArray *classNames = @[@"FirstViewController",@"MyTableViewController"];
    NSArray *imags = @[@"tabbar_home",@"tabbar_profile"];
    NSMutableArray *mArray = [NSMutableArray array];
    
    
    for (int idx = 0; idx < classNames.count; idx++) {
        NSString *selImg = [NSString stringWithFormat:@"%@_selected", [imags objectAtIndex:idx] ];
        id nav = [self viewControllerWithClassName: [classNames objectAtIndex:idx]
                                             image: [self changeImage:imags[idx]]
                                     selectedImage: [self changeImage:selImg]
                                             title: [titles objectAtIndex:idx]];
        [mArray addObject: nav];
    }
    self.viewControllers = mArray;
    self.tabBar.tintColor = [UIColor colorWithHexString:@"#ff8200" andAlpha:1];
    
}
- (UINavigationController *)viewControllerWithClassName:(NSString*)className image:(UIImage*)image selectedImage:(UIImage *)selectedImage title:(NSString *)title
{
    Class class = NSClassFromString( className );
    id pClass = [[class alloc]init];
    [pClass setTabBarItem: [[UITabBarItem alloc] initWithTitle: title image:image selectedImage:selectedImage] ];
    [pClass setTitle: title];
    UINavigationController *viewController = [[UINavigationController alloc] initWithRootViewController: pClass];
    return viewController;
}

-(UIImage *)changeImage:(NSString *)image{
    return [UIImage imageNamed:[NSString stringWithFormat:@"%@",image]];
    
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
