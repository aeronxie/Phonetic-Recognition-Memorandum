//
//  MeViewController.m
//  语音识别备忘录
//
//  Created by Fay on 15/7/31.
//  Copyright (c) 2015年 Fay. All rights reserved.
//

#import "MeViewController.h"
#import "ProfileViewController.h"
#import "CollectionViewCell.h"
#import "SettingViewController.h"
#import "CycleViewController.h"
#import "MainViewController.h"
#import "CollectViewController.h"
#import "ChatViewController.h"
#import "UIColor+Hash.h"

#define SIZE self.view.bounds.size

@interface MeViewController ()<UITableViewDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate,UIScrollViewDelegate>
{
    UIImagePickerController *_picker;
}


@property (weak, nonatomic) IBOutlet UIImageView *bgImageView;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *left;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *right;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *top;

@property (weak, nonatomic) IBOutlet UIImageView *roundHead;


@end

@implementation MeViewController
{
    CGRect _lastFrame;
    UIImageView *_background;
    
}




-(id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        
        
    }
    return self;

    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //[self navigationController].navigationBar.tintColor = [UIColor whiteColor];

    
    [self.tableView.tableHeaderView setFrame:CGRectMake(0, 0, self.view.bounds.size.width, 175)];;
    
    _lastFrame = self.bgImageView.frame;
    
    self.bgImageView.alpha = 0.6;
    
    //设置头像圆角
    _roundHead.layer.borderColor = [[UIColor whiteColor] CGColor];
    
    _roundHead.layer.borderWidth = 3.0;
    
    _roundHead.layer.cornerRadius = 50.0f;
    
    _roundHead.backgroundColor = [UIColor clearColor];
    
    _roundHead.layer.masksToBounds = YES;
    
    _roundHead.userInteractionEnabled = YES;
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(click)];
    
    [_roundHead addGestureRecognizer:tap];
    
    //self.tableView.backgroundColor = [UIColor colorWithRed:235/255.0 green:235/255.0 blue:241/255.0 alpha:1.0];
    self.tableView.backgroundColor = [UIColor whiteColor];
    
}


-(void)click {
    
    NSLog(@"-------------");
    ProfileViewController * pro = [[UIStoryboard storyboardWithName:@"Main" bundle:nil]instantiateViewControllerWithIdentifier:@"profile"];
    
    [self.navigationController pushViewController:pro animated:YES];
    
    self.navigationController.navigationBarHidden = NO;
    
}


-(void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    
    NSData *imageData = [[NSUserDefaults standardUserDefaults] dataForKey:@"headview"];
    
    UIImage *image = [UIImage imageWithData:imageData];
    
    self.roundHead.image = image;
    
    self.navigationController.navigationBarHidden = YES;
    
    self.tabBarController.tabBar.hidden = NO;
    
    NSString *color = [[NSUserDefaults standardUserDefaults] objectForKey:@"color"];
    
    [[UINavigationBar appearance]setBarTintColor:[UIColor colorFromHexString:color]];
    
    [[UINavigationBar appearance]setTintColor:[UIColor whiteColor]];

    
}


-(void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    CGFloat dragY = _lastFrame.origin.y - scrollView.contentOffset.y;
    
    if (scrollView.contentOffset.y <= 0.0 && scrollView.contentOffset.y >= -1000.0) {
        self.left.constant = -dragY / 2;
        self.right.constant = -dragY / 2;
        self.top.constant = -dragY;
        
    }else if (scrollView.contentOffset.y < -1000.0) {
        
        self.left.constant = -500;
        self.right.constant = -500;
        self.top.constant = -1000;
        
    }else {
        
        self.left.constant = -500;
        self.right.constant = -500;
        self.top.constant = -1000;
        
    }
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}




-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    _picker = [[UIImagePickerController alloc]init];
    
    _picker.delegate = self;
    
    
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    
    NSInteger tag = cell.tag;
    
    
    if (tag == 1) {
        
        _picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        
       
        [self presentViewController:_picker animated:YES completion:nil];
        
  
        
        
    }else if (tag == 2) {
        
        CollectViewController *collect = [[UIStoryboard storyboardWithName:@"Main" bundle:nil]instantiateViewControllerWithIdentifier:@"collect"];
        
        [self.navigationController pushViewController:collect animated:YES];
        
        self.tabBarController.tabBar.hidden = YES;
        
        self.navigationController.navigationBarHidden = NO;
        
     
        
    }else if (tag == 3) {
        
       ChatViewController *chat = [[UIStoryboard storyboardWithName:@"Main" bundle:nil]instantiateViewControllerWithIdentifier:@"chat"];
        
        [self.navigationController pushViewController:chat animated:YES];
        
        self.tabBarController.tabBar.hidden = YES;
        
        self.navigationController.navigationBarHidden = NO;
        
    }else if (tag == 4) {
        
        CycleViewController *cycle = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"cycle"];
        
        [self.navigationController pushViewController:cycle animated:YES];
        
        self.tabBarController.tabBar.hidden = YES;
        
        self.navigationController.navigationBarHidden = NO;

        
        
        
    }else {
        
        
        SettingViewController *set =  [[UIStoryboard storyboardWithName:@"Main" bundle:nil]instantiateViewControllerWithIdentifier:@"about"];
        
        [self.navigationController pushViewController:set animated:YES];
        
        self.tabBarController.tabBar.hidden = YES;
        
        self.navigationController.navigationBarHidden = NO;
        
    }
    
    
    
}




@end
