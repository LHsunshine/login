//
//  MainTableViewController.h
//  cocoaPodsTest
//
//  Created by 李慧 on 2017/7/6.
//  Copyright © 2017年 李慧. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol MainTableViewControllerDelegate<NSObject>
@end

@interface MainTableViewController : UITableViewController

@property (nonatomic,assign)id<MainTableViewControllerDelegate>delegate;
@property (retain,strong) UIImageView *topImage;
@end
