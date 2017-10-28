//
//  MyTableViewController.m
//  cocoaPodsTest
//
//  Created by 李慧 on 2017/7/6.
//  Copyright © 2017年 李慧. All rights reserved.
//

#import "MyTableViewController.h"
#import "ViewController.h"
#import <BmobSDK/Bmob.h>
#import <CoreLocation/CoreLocation.h>
#import "MainTableViewController.h"
#import "ShareController.h"
@interface MyTableViewController ()
@property(strong,nonatomic)UIView*topView;
@property(strong,nonatomic)UIImageView*touImage;
@property(strong,nonatomic)NSArray*groupInfo;
@property(strong,nonatomic)NSDictionary*infoDataDict;

@end
#define TBWidth self.view.frame.size.width
#define TBHeight self.view.frame.size.height-113
@implementation MyTableViewController
//@synthesize username;
-(NSArray *)groupInfo{
    if (!_groupInfo) {
        _groupInfo=[NSArray array];
        NSString*plistPath=[[NSBundle mainBundle]pathForResource:@"List.plist" ofType:nil];
        _groupInfo=[NSArray arrayWithContentsOfFile:plistPath];
    }
    return _groupInfo;
}

- (void)viewDidLoad {
    [super viewDidLoad];
//    BmobUser *bUser=[BmobUser currentUser];
//    self.username.text=bUser.mobilePhoneNumber;
//
    self.tableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, TBWidth, TBHeight) style:UITableViewStyleGrouped];
    self.tableView.delegate=self;
    self.tableView.dataSource=self;
    //设置导航栏的背景颜色
    self.navigationController.navigationBar.barTintColor=[UIColor orangeColor];
    [self.navigationController.navigationBar setTranslucent:NO];
    self.navigationItem.title=@"我的";
    //设置导航栏字体颜色
    [self.navigationController.navigationBar setTitleTextAttributes:
     @{NSFontAttributeName:[UIFont systemFontOfSize:19],
   NSForegroundColorAttributeName:[UIColor whiteColor]}];
    //绘制topView
    [self creatTopView];
    
}
-(void)creatTopView{
    self.topView=[[UIView alloc]init];
    self.topView.frame=CGRectMake(0, 0, self.view.frame.size.width, 100);
    self.topView.backgroundColor=[UIColor whiteColor];
    self.tableView.tableHeaderView=self.topView;
    //绘制头像Image
    self.touImage=[[UIImageView alloc]init];
    self.touImage.frame=CGRectMake(self.topView.frame.size.width/2-40, (self.topView.frame.size.height-80)/2, 80, 80);
    self.touImage.image=[UIImage imageNamed:@"my-Image"];
    self.touImage.layer.masksToBounds=YES;
    self.touImage.layer.cornerRadius=self.touImage.frame.size.width/2;
    self.touImage.layer.borderColor=(__bridge CGColorRef _Nullable)([UIColor whiteColor]);
    self.touImage.layer.borderWidth=3.0f;
    [self.topView addSubview:self.touImage];
    //绘制一个button放在topView上
    UIButton*button1=[[UIButton alloc]init];
    button1.frame=CGRectMake(0, 0, self.view.frame.size.width, self.topView.frame.size.height);
    button1.backgroundColor=[UIColor clearColor];
    [self.topView addSubview:button1];
    [button1 addTarget:self action:@selector(enterInformation:) forControlEvents:UIControlEventTouchUpInside];
    
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.groupInfo.count;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSArray*array=self.groupInfo[section];
    return array.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString*Identifier=@"CellIdentifier";
    UITableViewCell*cell=[tableView dequeueReusableCellWithIdentifier:Identifier];
    if (cell==nil) {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:Identifier];
    }
    cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
    NSUInteger row=[indexPath row];
    NSInteger section=[indexPath section];
    NSDictionary*group=self.groupInfo[section][row];
    cell.textLabel.text=group[@"name"];
    //cell.imageView.image=[UIImage imageNamed:group[@"image"]];
    
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section==2) {
        if (indexPath.row==0) {
            ShareController*share=[[ShareController alloc]initWithInitialDate];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                //  [self.detailUserInfo setValue:selectedDate forKey:@"birth"];
                [self.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
            });
            
            [self.tableView addSubview:share];
        }
    }else{
//        NSDictionary*group=self.groupInfo[indexPath.section][indexPath.row];
//        NSString*controllerName=group[@"controller"];
//        NSString*name=group[@"name"];
//        [self pushController:controllerName withtitle:name];
    }
}
//-(void)pushController:(NSString*)viewController withtitle:(NSString*)title{
//    self.navigationItem.backBarButtonItem=[[UIBarButtonItem alloc]initWithTitle:title style:UIBarButtonItemStylePlain target:self action:nil];
//    Class ViewController=NSClassFromString(viewController);
//    UIViewController*controller=[[ViewController alloc]init];
//    [self.navigationController pushViewController:controller animated:YES];
//}
-(void)enterInformation:(id)sender{
    MainTableViewController*infoView=[[MainTableViewController alloc]init];
    self.navigationItem.backBarButtonItem=[[UIBarButtonItem alloc]initWithTitle:@"我的" style:UIBarButtonItemStylePlain target:self action:nil];
    self.navigationItem.backBarButtonItem.tintColor=[UIColor whiteColor];
    [self.navigationController pushViewController:infoView animated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
/*
#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
#warning Incomplete implementation, return the number of sections
    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete implementation, return the number of rows
    return 0;
}
*/
/*
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:<#@"reuseIdentifier"#> forIndexPath:indexPath];
    
    // Configure the cell...
    
    return cell;
}
*/

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)logout:(id)sender {
    [BmobUser logout];//注销
    NSLog(@"注销成功");
    }
@end
