//
//  ProfileViewController.m
//  语音识别备忘录
//
//  Created by Fay on 15/7/31.
//  Copyright (c) 2015年 Fay. All rights reserved.
//

#import "ProfileViewController.h"
#import "EditProfileViewController.h"
#import "UIColor+Hash.h"

@interface ProfileViewController ()<UIActionSheetDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>

@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UIImageView *headView;
@property (weak, nonatomic) IBOutlet UILabel *number;
@property (weak, nonatomic) IBOutlet UILabel *email;
@property (weak, nonatomic) IBOutlet UILabel *place;
@property (weak, nonatomic) IBOutlet UILabel *sex;
@property (weak, nonatomic) IBOutlet UILabel *birthday;
@property (weak, nonatomic) IBOutlet UILabel *smartSign;

@end

@implementation ProfileViewController

-(void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    
    NSString *color = [[NSUserDefaults standardUserDefaults] objectForKey:@"color"];
    
    [self.navigationController.navigationBar setBarTintColor:[UIColor colorFromHexString:color]];

    
}


- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.title = @"个人信息";
    self.number.text = @"SilverFoxx";
    self.name.text = @"小飞侠";
    self.email.text = @"279698034@qq.com";
    self.place.text = @"中国吉林长春";
    self.sex.text = @"男";
    self.birthday.text = @"2015年1月15日";
    self.smartSign.text = @"我是小武神";
    
    
    _headView.layer.borderColor = [[UIColor whiteColor] CGColor];
    
    _headView.layer.borderWidth = 3.0;
    
    _headView.layer.cornerRadius = 40.0f;
    
    _headView.backgroundColor = [UIColor clearColor];
    
    _headView.layer.masksToBounds = YES;

    
    
    NSData *imageData = [[NSUserDefaults standardUserDefaults] dataForKey:@"headview"];
    
    UIImage *image = [UIImage imageWithData:imageData];
    
    self.headView.image = image;
    
    self.tableView.backgroundColor = [UIColor whiteColor];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}




-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    
    NSInteger tag = cell.tag;
    
    //选择照片
    if (tag == 0) {
        UIActionSheet *sheet = [[UIActionSheet alloc]initWithTitle:@"请选择" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:@"照相" otherButtonTitles:@"从手机相册选择", nil];
        
        [sheet showInView:self.view];
        
    }
        if (tag == 1) {
            
            [self performSegueWithIdentifier:@"editsegue" sender:cell];
    
           
        }else {
            
            return;
            
        }
    
}

//传值
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    //获取编辑个人信息的控制器
    id destinationVC = segue.destinationViewController;
    
    if ([destinationVC isKindOfClass:[EditProfileViewController class]] ) {
        
        EditProfileViewController *editVC = destinationVC;
        
        editVC.cell = sender;
    }
    
}


#pragma mark actionsheet代理
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    
    
    //图片编辑器
    UIImagePickerController *imagePicker = [[UIImagePickerController alloc]init];
    
    //设置代理
    imagePicker.delegate = self;
    
    //允许图片编辑
    imagePicker.allowsEditing = YES;
    
    if (buttonIndex == 0) {
        imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
        
    }
    
    if (buttonIndex == 1) {
        imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    
    }else{
        
        return;
        
        
    }
    
    //显示图片编辑器
    
    [self presentViewController:imagePicker animated:YES completion:nil];
    
    
}

#pragma mark 图片选择器代理
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    
    //获取图片
    UIImage *image = info[UIImagePickerControllerEditedImage];
    
    self.headView.image = image;
    
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    NSData *imageData = UIImageJPEGRepresentation(image, 100);
    
    [defaults setObject:imageData forKey:@"headview"];
    
    
    [defaults synchronize];
    
    
    
    //隐藏当前模态窗口
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
}

@end
