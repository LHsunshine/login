//
//  AppDelegate.m
//  登录注册
//
//  Created by 李慧 on 2017/8/2.
//  Copyright © 2017年 李慧. All rights reserved.
//

#import "AppDelegate.h"
#import "ViewController.h"
#import "RootTabBarViewController.h"
#import <BmobSDK/Bmob.h>
#import <IQKeyboardManager.h>
#import "PrefixHeader.pch"


@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    ViewController *VC=[[ViewController alloc]init];   // 登录是首个页面
    UINavigationController *nav=[[UINavigationController alloc]init];
    self.window.rootViewController = nav; // 根试图控制器
    // 判断是否第一次启动，是否加载新手指引。去viewWillAppear下一步
    if(![[NSUserDefaults standardUserDefaults] boolForKey:@"firstLaunch"])
    {
        
        [[NSUserDefaults standardUserDefaults]setBool:YES forKey:@"firstLaunch"];   // 第一次启动
        
        NSLog(@"第一次启动");
        // 登录
        [nav pushViewController:VC animated:YES];   // nav 是导航控制器
        
        
        
    }
    else
    {
        NSLog(@"不是第一次启动");
        // 新手导航
        RootTabBarViewController *guide = [[RootTabBarViewController alloc]init];
        [nav pushViewController:guide animated:YES];   // nav 是导航控制器
        nav.navigationBarHidden = YES;  // 隐藏导航栏
        //self.window.rootViewController = nav; // 根试图控制器
    }
    //设置NavigationBar背景颜色为白色
    //    [[UINavigationBar appearance] setBarTintColor:[UIColor whiteColor]];    // 导航栏的颜色是白色
    //    NSDictionary *attributes=[NSDictionary dictionaryWithObjectsAndKeys:[UIColor colorWithRed:248/255.0f green:144/255.0f blue:34/255.0f alpha:1],NSForegroundColorAttributeName,nil];  // 橙色
    //
    //    [nav.navigationBar setTitleTextAttributes:attributes];  // 导航栏的标题颜色为橙色
    
    [Bmob registerWithAppKey:kBmobKey];//申请的授权Key
    
    
    // 键盘
    IQKeyboardManager *manager = [IQKeyboardManager sharedManager];
    manager.enable = YES;
    manager.shouldResignOnTouchOutside = YES;
    manager.shouldToolbarUsesTextFieldTintColor = YES;
    manager.enableAutoToolbar = YES;
    // Override point for customization after application launch.
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
