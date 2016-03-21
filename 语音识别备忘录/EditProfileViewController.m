//
//  EditProfileViewController.m
//  语音识别备忘录
//
//  Created by Fay on 15/8/1.
//  Copyright (c) 2015年 Fay. All rights reserved.
//

#import "EditProfileViewController.h"

@interface EditProfileViewController ()
@property (weak, nonatomic) IBOutlet UITextField *textfield;

@end

@implementation EditProfileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = self.cell.textLabel.text;
    
    self.textfield.text = self.cell.detailTextLabel.text;

    //右边添加一个保存按钮
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"保存" style:UIBarButtonItemStylePlain target:self action:@selector(saveBtn)];

}


-(void)saveBtn{
    
    self.cell.detailTextLabel.text = self.textfield.text;
    
    [self.navigationController popViewControllerAnimated:YES];
    
    [self.cell layoutSubviews];

    
}


@end
