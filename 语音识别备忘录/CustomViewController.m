//
//  CustomViewController.m
//  语音识别备忘录
//
//  Created by Fay on 15/8/6.
//  Copyright (c) 2015年 Fay. All rights reserved.
//

#import "CustomViewController.h"


@interface CustomViewController ()<UIImagePickerControllerDelegate,UINavigationControllerDelegate>

@end

@implementation CustomViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"自定义墙纸";
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    
    NSString *color = [[NSUserDefaults standardUserDefaults] objectForKey:@"color"];
    
    [self.navigationController.navigationBar setBarTintColor:[self colorFromHexString:color]];
    
    
}


#pragma mark HASH颜色算法

-(UIColor *)colorFromHexString:(NSString *)hexString {
    NSString *cString = [[hexString stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
    
    // String should be 6 or 8 characters
    if ([cString length] < 6) return [UIColor grayColor];
    
    // strip 0X if it appears
    if ([cString hasPrefix:@"0X"]) cString = [cString substringFromIndex:2];
    
    if ([cString hasPrefix:@"#"]) cString = [cString substringFromIndex:1];
    
    if ([cString length] != 6) return [UIColor grayColor];
    
    // Separate into r, g, b substrings
    NSRange range;
    range.location = 0;
    range.length = 2;
    NSString *rString = [cString substringWithRange:range];
    
    range.location = 2;
    NSString *gString = [cString substringWithRange:range];
    
    range.location = 4;
    NSString *bString = [cString substringWithRange:range];
    
    // Scan values
    unsigned int r, g, b;
    [[NSScanner scannerWithString:rString] scanHexInt:&r];
    [[NSScanner scannerWithString:gString] scanHexInt:&g];
    [[NSScanner scannerWithString:bString] scanHexInt:&b];
    
    return [UIColor colorWithRed:((float) r / 255.0f)
                           green:((float) g / 255.0f)
                            blue:((float) b / 255.0f)
                           alpha:1.0f];
    
    
}








#pragma mark 图片选择器代理
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    
    //获取图片
    UIImage *image = info[UIImagePickerControllerEditedImage];
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    NSData *imageData = UIImageJPEGRepresentation(image, 100);
    
    [defaults setObject:imageData forKey:@"wall"];
    
    [defaults synchronize];
    
    //[self dismissViewControllerAnimated:YES completion:nil];
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
}


- (IBAction)addWalls:(id)sender {
    
    UIImagePickerController *picker = [[UIImagePickerController alloc]init];
    
    picker.delegate = self;
    
    //允许图片编辑
    picker.allowsEditing = YES;
    
    picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        
        
    [self presentViewController:picker animated:YES completion:nil];
    
}
@end
