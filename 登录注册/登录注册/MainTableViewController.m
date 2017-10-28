//
//  MainTableViewController.m
//  cocoaPodsTest
//
//  Created by 李慧 on 2017/7/6.
//  Copyright © 2017年 李慧. All rights reserved.
//

#import "MainTableViewController.h"
#import "LoginViewController.h"
#import "ViewController.h"
#import <BmobSDK/Bmob.h>
#import "BRTextField.h"
#import "NSDate+BRAdd.h"
#import <BRPickerView.h>
#define TBWidth self.view.frame.size.width
#define TBHeight self.view.frame.size.height-113
@interface MainTableViewController ()<UITextFieldDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate,UIActionSheetDelegate>


/** 头像 */

@property (nonatomic, strong) BRTextField *topImageTF;
/** 姓名 */
@property (nonatomic, strong) BRTextField *nameTF;
/** 昵称 */
@property (nonatomic, strong) BRTextField *nicnameTF;
/** 性别 */
@property (nonatomic, strong) BRTextField *genderTF;
/** 出生年月 */
@property (nonatomic, strong) BRTextField *birthdayTF;
/** 出生时刻 */
@property (nonatomic, strong) BRTextField *birthtimeTF;
/** 联系方式 */
@property (nonatomic, strong) BRTextField *phoneTF;
/** 地区 */
@property (nonatomic, strong) BRTextField *addressTF;
/** 学历 */
@property (nonatomic, strong) BRTextField *educationTF;
/** 学校 */
@property (nonatomic, strong) BRTextField *schoolTF;
/** 专业 */
@property (nonatomic, strong) BRTextField *majorTF;
/** 其它 */
@property (nonatomic, strong) BRTextField *otherTF;

@property (nonatomic, strong) NSArray *titleArr;

//@property BmobFile *file;

//@property  NSData *imageData;



@end

@implementation MainTableViewController
- (NSArray *)titleArr {
    if (!_titleArr) {
        _titleArr=[NSArray array];
        NSString *plistPath=[[NSBundle mainBundle]pathForResource:@"main.plist" ofType:nil];
        _titleArr=[NSArray arrayWithContentsOfFile:plistPath];
    }
    return _titleArr;
}

- (void)viewDidLoad {
    self.navigationItem.title = @"个人资料";
    self.tableView.hidden = NO;
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"保存" style:UIBarButtonItemStylePlain target:self action:@selector(clickSaveBtn)];
    self.navigationItem.rightBarButtonItem.tintColor=[UIColor whiteColor];
    self.tableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, TBWidth, TBHeight) style:UITableViewStyleGrouped];
    self.tableView.delegate=self;
    self.tableView.dataSource=self;
    //设置导航栏的背景颜色
    self.navigationController.navigationBar.barTintColor=[UIColor orangeColor];
    [self.navigationController.navigationBar setTranslucent:NO];
    //设置导航栏字体颜色
    [self.navigationController.navigationBar setTitleTextAttributes:
     @{NSFontAttributeName:[UIFont systemFontOfSize:19],
       NSForegroundColorAttributeName:[UIColor whiteColor]}];


    UIButton*logoutBtn=[[UIButton alloc]init];
    logoutBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    logoutBtn.frame=CGRectMake(10, 640, self.view.bounds.size.width-20, 40);
    [logoutBtn setTitle:@"退出账户" forState: UIControlStateNormal];
    [logoutBtn addTarget:self action:@selector(logoutBtn:) forControlEvents:UIControlEventTouchUpInside];
    logoutBtn.backgroundColor=[UIColor orangeColor];
    logoutBtn.layer.cornerRadius=5;
    [self.tableView addSubview:logoutBtn];
    //self.tableView.tableFooterView=tuichuBtn;
    
   
    
    
    BmobUser *user=[BmobUser currentUser];
    BmobQuery *bquery = [BmobQuery queryForUser];
    //查找GameScore表里面id为0c6db13c的数据
    [bquery getObjectInBackgroundWithId:user.objectId block:^(BmobObject *object,NSError *error){
        if (error){
            //进行错误处理
        }else{
            //表里有id为0c6db13c的数据
            if (object) {
                //得到playerName和cheatMode
                
                
                
                NSString *name = [object objectForKey:@"name"];
                self.nameTF.text=name;

                NSString *nickname = [object objectForKey:@"nickname"];
                self.nicnameTF.text=nickname;
                
                NSString *gender = [object objectForKey:@"sex"];
                self.genderTF.text=gender;
                
//                NSString *birthday = [object objectForKey:@"birthday"];
//                self.birthdayTF.text=birthday;
                
                NSString *phone = [object objectForKey:@"phone"];
                self.phoneTF.text=phone;
                
                NSString *address = [object objectForKey:@"area"];
                self.addressTF.text=address;
                
                NSString *education = [object objectForKey:@"education"];
                self.educationTF.text=education;
                
                NSString *school = [object objectForKey:@"college"];
                self.schoolTF.text=school;
                
                NSString *major = [object objectForKey:@"major"];
                self.majorTF.text=major;
                
                
                NSDate *birthday = [object objectForKey:@"birthday"];
                 NSString *birthday1=[NSString stringWithFormat:@"%@",birthday];
                self.birthdayTF.text=birthday1;
                

            }
        }
    }];


}
#pragma mark - UITableViewDataSource, UITableViewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 3;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section==0) {
        return 7;
    }
    else if(section==1){
        return 3;
    }
    else
        return 0;
}
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    if (section==0) {
        return @"个人信息";
    }
    else if(section==1){
        return @"教育";
    }
    else
        return nil;
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellID = @"testCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.textLabel.font = [UIFont systemFontOfSize:16.0f];
    cell.textLabel.textColor = RGB_HEX(0x464646, 1.0f);
    NSUInteger row=[indexPath row];
    NSUInteger section=[indexPath section];
    
    NSDictionary *group=self.titleArr[section][row];
    NSString *title=group[@"name"];
    if ([title hasPrefix:@"* "]) {
        NSMutableAttributedString *textStr = [[NSMutableAttributedString alloc]initWithString:title];
        [textStr addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:[[textStr string]rangeOfString:@"* "]];
        cell.textLabel.attributedText = textStr;
    } else {
        cell.textLabel.text = title;
    }
    if (section==0) {
     switch (indexPath.row) {
         case 0:
         {
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
             [self setuptopImageTF:cell];
         }
             break;
        case 1:
        {
            cell.accessoryType = UITableViewCellAccessoryNone;
            [self setupNameTF:cell];
        }
            break;
        case 2:
        {
            cell.accessoryType = UITableViewCellAccessoryNone;
            [self setupNicNameTF:cell];
        }
            break;
        case 3:
        {
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            [self setupGenderTF:cell];
        }
            break;
        case 4:
        {
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            [self setupBirthdayTF:cell];
           
        }
            break;
         case 5:
         {
             cell.accessoryType = UITableViewCellAccessoryNone;
             [self setupPhoneTF:cell];
         }
             break;
         case 6:
         {
             cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
             [self setupAddressTF:cell];
         }
             break;
         default:
             break;
     }
    }else if (section==1){
         switch (row) {
        case 0:
        {
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            [self setupEducationTF:cell];
        }
            break;
        case 1:
        {
           cell.accessoryType = UITableViewCellAccessoryNone;
           [self setupSchoolTF:cell];
        }
            break;
        case 2:
        {
           cell.accessoryType = UITableViewCellAccessoryNone;
            [self setupMajorTF:cell];
        }
            break;
             default:
                 break;
         }
    }else if(section==2){
        switch (row) {
        case 0:
        {
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            //[self setupEducationTF:cell];
        }
            break;
        case 1:
            {
                cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
                //[self setupEducationTF:cell];
            }
                break;
    
        default:
            break;
    }
    }
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 50;
}

- (BRTextField *)getTextField:(UITableViewCell *)cell {
    BRTextField *textField = [[BRTextField alloc]initWithFrame:CGRectMake(SCREEN_WIDTH - 230, 0, 200, 50)];
    textField.backgroundColor = [UIColor clearColor];
    textField.font = [UIFont systemFontOfSize:16.0f];
    textField.textAlignment = NSTextAlignmentRight;
    textField.textColor = RGB_HEX(0x666666, 1.0);
    textField.delegate = self;
    [cell.contentView addSubview:textField];
    return textField;
}




- (void)setuptopImageTF:(UITableViewCell *)cell {
    if (!_topImageTF) {
        _topImageTF = [self getTextField:cell];
        _topImage=[[UIImageView alloc]init];
        _topImage.frame=CGRectMake(SCREEN_WIDTH - 215, 5, 40, 40);
        [_topImageTF addSubview:_topImage];
//         _topImageTF.placeholder = @"请选择";
//
        __weak typeof(self) weakSelf = self;
        _topImageTF.tapAcitonBlock = ^{
//        [[ZZYPhotoHelper shareHelper] showImageViewSelcteWithResultBlock:^(id data) {
//        weakSelf.topImage.image = (UIImage *)data;
//            }];
//       };
 //       weakSelf.topImageTF.background=self.topImage.image;
//       // 创建一个UIImagePickerController对象
        UIImagePickerController *imagePickerController=[[UIImagePickerController alloc]init];
                //    设置代理
        imagePickerController.delegate=weakSelf;
                //   设置可编辑
        imagePickerController.allowsEditing=YES;
                //    创建提示框，提示选择照相机还是系统相册
        UIAlertController *alert=[UIAlertController alertControllerWithTitle:@"选取图片" message:nil preferredStyle:UIAlertControllerStyleActionSheet];

        UIAlertAction *camerAction=[UIAlertAction actionWithTitle:@"拍照" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action){
                    //        选择相机时设置UIImagePickerController对象相关属性
        imagePickerController.sourceType=UIImagePickerControllerSourceTypeCamera;//照相机
        imagePickerController.cameraDevice=UIImagePickerControllerCameraDeviceRear;//后置摄像头
                    //        UIImagePickerControllerCameraDeviceFront 前置摄像头
                    //     跳转到 UIImagePickerController控制器弹出相机
        [weakSelf presentViewController:imagePickerController animated:YES completion: ^{}];
                }];


        UIAlertAction *photoAction=[UIAlertAction actionWithTitle:@"从相册选择" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action){
                    //        选择相册时设置UIImagePickerController对象相关属性
        imagePickerController.sourceType=UIImagePickerControllerSourceTypePhotoLibrary;//相册
                    //跳转到UIImagePickerController控制器弹出相册
        [weakSelf presentViewController:imagePickerController animated:YES completion:^{}];
                }];
                //    取消按钮
        UIAlertAction *cancelAction=[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action){
                }];

        if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
                    //        添加各个按钮事件
                    [alert addAction:camerAction];
                    [alert addAction:photoAction];
                    [alert addAction:cancelAction];
                    //        弹出提示框
                    [weakSelf presentViewController:alert animated:YES completion:nil];
                }
        };
        weakSelf.topImageTF.background=self.topImage.image;
//           //  weakSelf.topImageTF.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"my-Image"]];
//              weakSelf.topImageTF.backgroundColor=[UIColor redColor];
//        //_topImageTF.placeholder = @"请输入";
////        _topImageTF.returnKeyType = UIReturnKeyDone;
////        _topImageTF.tag = 0;
//        };
    }
}
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info
{
    //获取到的图片
    UIImage *image=[info objectForKey:UIImagePickerControllerEditedImage];
    //    UIImagePickerControllerOriginalImage 原始图片
    //    UIImagePickerControllerEditedImage 修改后的图片
    self.topImage.image = image;
    //self.imageView.image=image;
    //    关闭模态视图
    [picker dismissViewControllerAnimated:YES completion:^{
        
    }];
    
    //    SEL selectorToCall=@selector(image:didFinishSavingWithError:contextInfo:);
    //    UIImageWriteToSavedPhotosAlbum(image, self, selectorToCall, NULL);
}

-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    //关闭模态视图
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)uploadImage:(UIImage *)image{
    //图片按1的质量压缩，转换成NSData
    //    UIImageJPEGRepresentation 方法在耗时上比较少 而 UIImagePNGRepresentation 耗时操作时间比较长，如果没有对图片质量要求太高，建议优先使用UIImageJPEGRepresentation
   // self.imageData=UIImageJPEGRepresentation(image, 1);
    
    //图片保存至沙盒
    //    NSArray *paths=NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    //    NSString *doucument=paths[0];
    //    NSString *fullpath=[doucument stringByAppendingPathComponent:@"photo.jpg"];
    //    [imageData writeToFile:fullpath atomically:YES];
    
    
    //    添加一个名为Notes的表
    //BmobObject *notes=[BmobObject objectWithClassName:@"Notes"];
    //创建Bmob文件夹把图片数据保存进去
   // BmobObject *photo=[[BmobObject alloc]initWithClassName:@"_User"];
    // BmobObject *photo=[BmobObject objectWithClassName:@"_User"];
    
    //    上传
//    [self.file saveInBackground:^(BOOL isSuccessful,NSError *error){
//        //如果文件保存成功，则把文件添加到photo列
//        if (isSuccessful) {
//
//
//       // [photo setObject:file forKey:@"photo"];
//       // [photo saveInBackground];
//            UIAlertController *alert=[UIAlertController alertControllerWithTitle:nil message:@"上传成功!"preferredStyle:UIAlertControllerStyleAlert];
//            [self presentViewController:alert animated:YES completion:nil];//弹出提示框
//            [self performSelector:@selector(dismiss:) withObject:alert afterDelay:1];//设置时间
//
//            NSLog(@"file url %@",self.file.url);
//
//        }
//        else{
//            UIAlertController *alert=[UIAlertController alertControllerWithTitle:nil message:@"上传失败!请重试！"preferredStyle:UIAlertControllerStyleAlert];
//            [self presentViewController:alert animated:YES completion:nil];//弹出提示框
//            [self performSelector:@selector(dismiss:) withObject:alert afterDelay:1];//设置时间
//
//            NSLog(@"%@",error);
//        }
//
//    }];
}
//-(void)dismiss:(UIAlertController *)alert
//{
//    [alert dismissViewControllerAnimated:YES completion:nil];//提示框自动消失
//}

-(void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo{
    //是否将图片保存至相册
    if (error==nil) {
        NSLog(@"successfully");
    }
    else{
        NSLog(@"Error=%@",error);
    }
}

- (void)setupNameTF:(UITableViewCell *)cell {
    if (!_nameTF) {
        _nameTF = [self getTextField:cell];
        _nameTF.placeholder = @"请输入";
        _nameTF.returnKeyType = UIReturnKeyDone;
        _nameTF.tag = 0;
    }
}
- (void)setupNicNameTF:(UITableViewCell *)cell {
    if (!_nicnameTF) {
        _nicnameTF = [self getTextField:cell];
        _nicnameTF.placeholder = @"请输入";
        _nicnameTF.returnKeyType = UIReturnKeyDone;
        _nicnameTF.tag = 0;
    }
}
#pragma mark - 性别 textField
- (void)setupGenderTF:(UITableViewCell *)cell {
    if (!_genderTF) {
        _genderTF = [self getTextField:cell];
        _genderTF.placeholder = @"请选择";
        __weak typeof(self) weakSelf = self;
        _genderTF.tapAcitonBlock = ^{
            [BRStringPickerView showStringPickerWithTitle:@"性别" dataSource:@[@"男", @"女", @"其他"] defaultSelValue:@"男" isAutoSelect:YES resultBlock:^(id selectValue) {
                weakSelf.genderTF.text = selectValue;
            }];
        };
    }
}

#pragma mark - 出生日期 textField
- (void)setupBirthdayTF:(UITableViewCell *)cell {
    if (!_birthdayTF) {
        _birthdayTF = [self getTextField:cell];
        _birthdayTF.placeholder = @"请选择";
        __weak typeof(self) weakSelf = self;
        _birthdayTF.tapAcitonBlock = ^{
            [BRDatePickerView showDatePickerWithTitle:@"出生年月" dateType:UIDatePickerModeDate defaultSelValue:weakSelf.birthdayTF.text minDateStr:@"" maxDateStr:[NSDate currentDateString] isAutoSelect:YES resultBlock:^(NSString *selectValue) {
                weakSelf.birthdayTF.text = selectValue;
            }];
        };
    }
}



#pragma mark - 联系方式 textField
- (void)setupPhoneTF:(UITableViewCell *)cell {
    if (!_phoneTF) {
        _phoneTF = [self getTextField:cell];
        _phoneTF.placeholder = @"请输入";
        _phoneTF.returnKeyType = UIReturnKeyDone;
        _phoneTF.tag = 0;
    }
}

#pragma mark - 地址 textField
- (void)setupAddressTF:(UITableViewCell *)cell {
    if (!_addressTF) {
        _addressTF = [self getTextField:cell];
        _addressTF.placeholder = @"请选择";
        __weak typeof(self) weakSelf = self;
        _addressTF.tapAcitonBlock = ^{
            [BRAddressPickerView showAddressPickerWithDefaultSelected:@[@10, @0, @3] isAutoSelect:YES resultBlock:^(NSArray *selectAddressArr) {
                weakSelf.addressTF.text = [NSString stringWithFormat:@"%@%@%@", selectAddressArr[0], selectAddressArr[1], selectAddressArr[2]];
            }];
        };
    }
}

#pragma mark - 学历 textField
- (void)setupEducationTF:(UITableViewCell *)cell {
    if (!_educationTF) {
        _educationTF = [self getTextField:cell];
        _educationTF.placeholder = @"请选择";
        __weak typeof(self) weakSelf = self;
        _educationTF.tapAcitonBlock = ^{
            [BRStringPickerView showStringPickerWithTitle:@"学历" dataSource:@[@"大专以下", @"大专", @"本科", @"硕士", @"博士", @"博士后"] defaultSelValue:@"本科" isAutoSelect:YES resultBlock:^(id selectValue) {
                weakSelf.educationTF.text = selectValue;
            }];
        };
    }
}
#pragma mark - 学校 textField
- (void)setupSchoolTF:(UITableViewCell *)cell {
    if (!_schoolTF) {
        _schoolTF = [self getTextField:cell];
        _schoolTF.placeholder = @"请输入";
        _schoolTF.returnKeyType = UIReturnKeyDone;
        _schoolTF.tag = 0;
    }
}
#pragma mark - 专业 textField
- (void)setupMajorTF:(UITableViewCell *)cell {
    if (!_majorTF) {
        _majorTF = [self getTextField:cell];
        _majorTF.placeholder = @"请输入";
        _majorTF.returnKeyType = UIReturnKeyDone;
        _majorTF.tag =0;
    }
}


#pragma mark - UITextFieldDelegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    if (textField.tag == 0 || textField.tag == 4) {
        [textField resignFirstResponder];
    }
    return YES;
}
- (void)clickSaveBtn {
    BmobUser *bUser = [BmobUser currentUser];
         //保存名字
   // BmobUser *photo=[BmobUser objectWithClassName:@"_User"];
    
    NSData*imageData=UIImageJPEGRepresentation(self.topImage.image, 1);
    
   // BmobObject *obj=[[BmobObject alloc]initFromBmobObject:[BmobUser currentUser]];
    BmobObject *obj=[BmobObject objectWithClassName:@"_User"];
    
    BmobFile * file = [[BmobFile alloc]initWithFileName:@"photo.jpg"  withFileData:imageData];
    
    [file saveInBackground:^(BOOL isSuccessful,NSError *error){
                //如果文件保存成功，则把文件添加到photo列
        if (isSuccessful) {
        
            [obj setObject:file forKey:@"photo"];
            [obj saveInBackground];
                    UIAlertController *alert=[UIAlertController alertControllerWithTitle:nil message:@"上传成功!"preferredStyle:UIAlertControllerStyleAlert];
                    [self presentViewController:alert animated:YES completion:nil];//弹出提示框
                    [self performSelector:@selector(dismiss:) withObject:alert afterDelay:1];//设置时间

                    NSLog(@"file url %@",file.url);

                }
                else{
                    UIAlertController *alert=[UIAlertController alertControllerWithTitle:nil message:@"上传失败!请重试！"preferredStyle:UIAlertControllerStyleAlert];
                    [self presentViewController:alert animated:YES completion:nil];//弹出提示框
                    [self performSelector:@selector(dismiss:) withObject:alert afterDelay:1];//设置时间

                    NSLog(@"%@",error);
               }
//
          }];
   
    

    [bUser setObject:self.nameTF.text forKey:@"name"];
         //保存昵称
    [bUser setObject:self.nicnameTF.text forKey:@"nickname"];
    //保存性别
    [bUser setObject:self.genderTF.text forKey:@"sex"];
    //保存出生年月
   // [bUser setObject:self.birthdayTF.text forKey:@"birthday"];
    //保存联系方式
    [bUser setObject:self.phoneTF.text forKey:@"phone"];
    //保存家庭地址
    [bUser setObject:self.addressTF.text forKey:@"area"];
    //保存学历
    [bUser setObject:self.educationTF.text forKey:@"education"];
    //保存学校
    [bUser setObject:self.schoolTF.text forKey:@"college"];
    //保存专业
    [bUser setObject:self.majorTF.text forKey:@"major"];
//        //保存生日
    NSString *string = self.birthdayTF.text;
    NSDateFormatter* formater = [[NSDateFormatter alloc] init];
    [formater setDateFormat:@"yyyy-MM-dd"];
     NSDate* date = [formater dateFromString:string];
    [bUser setObject:date forKey:@"birthday"];
        if (!self.nameTF.text || [self.nameTF.text isEqualToString:@""] )//判断文本框是否为空，如果有任何一项为空，则弹出警告框
        {
            UIAlertController *tip=[UIAlertController alertControllerWithTitle:@"警告" message:@"不能为空" preferredStyle:UIAlertControllerStyleAlert];//初始化UIAlertController参数，设置警告框内容
            [tip addAction:[UIAlertAction actionWithTitle:@"知道了" style:UIAlertActionStyleDefault handler:^(UIAlertAction* _Nonnull action)//创建UIAlertAction对象，相当于一个按钮
                            {
    
                            }]];
            [self presentViewController:tip animated:true completion:nil];//显示UIAlertController对象
    
        } else {
    
        [bUser updateInBackgroundWithResultBlock:^(BOOL isSuccessful, NSError *error) {
            if (isSuccessful) {//如果保存成功，弹出提示框
                
               //[self uploadImage:self.topImage.image];
                UIAlertController *alertView=[UIAlertController alertControllerWithTitle:@"提示" message:@"保存成功" preferredStyle:UIAlertControllerStyleAlert];
                [alertView addAction:[UIAlertAction actionWithTitle:@"知道了" style:UIAlertActionStyleDefault handler:^(UIAlertAction* _Nonnull action)
                                      {
    
                                      }]];
    
                [self presentViewController:alertView animated:YES completion:nil];
    
            }
            else {
                //如果保存失败，弹出警告框
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
}
-(void)dismiss:(UIAlertController *)alert
{
    [alert dismissViewControllerAnimated:YES completion:nil];//提示框自动消失
}
-(void)logoutBtn:(id)sender{
    ViewController*viewController=[[ViewController alloc]init];
    UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:viewController];
    UIWindow*window=[UIApplication sharedApplication].keyWindow;
    window.rootViewController=navigationController;
    [BmobUser logout];
}


@end
