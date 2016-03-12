
//
//  CycleViewController.m
//  语音识别备忘录
//
//  Created by Fay on 15/8/6.
//  Copyright (c) 2015年 Fay. All rights reserved.
//

#import "CycleViewController.h"
#import "CycleScrollView.h"
#import "CustomViewController.h"



@interface CycleViewController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)UICollectionView *collection;

@end

@implementation CycleViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    self.title = @"墙纸";
    
    [self.tableView.tableHeaderView setFrame:CGRectMake(0, 0, self.view.bounds.size.width, 44)];
    
    self.tableView.showsVerticalScrollIndicator = NO;
    
    [self.collection registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"svip"];
    
    //self.tableView.backgroundColor = [UIColor whiteColor];
    self.tableView.backgroundColor = [UIColor colorWithRed:235/255.0 green:235/255.0 blue:241/255.0 alpha:1.0];
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


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
   
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    if (cell == nil) {
        
       cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"cell"];
    }
    
    if (indexPath.section == 0) {
        
        
        CycleScrollView *cycleScrollView = [[CycleScrollView alloc] initWithFrame:CGRectMake(0, 0,self.view.frame.size.width, 120) animationDuration:2.0];
        
        NSMutableArray *viewArray = [[NSMutableArray alloc] init];
        for (int i = 0; i < 5; i++) {
            UIImageView *tempImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 120)];
            
            
            tempImageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"%d.jpg",i+1]];
            tempImageView.contentMode = UIViewContentModeScaleAspectFill;
            tempImageView.clipsToBounds = true;
            [viewArray addObject:tempImageView];
        }
        [cycleScrollView setFetchContentViewAtIndex:^UIView *(NSInteger(pageIndex)) {
            return [viewArray objectAtIndex:pageIndex];
        }];
        [cycleScrollView setTotalPagesCount:^NSInteger{
            return 5;
        }];
        [cycleScrollView setTapActionBlock:^(NSInteger(pageIndex)) {
            
            NSLog(@"点击的相关的页面%ld",(long)pageIndex);
            
        }];
        
        [cell addSubview:cycleScrollView];
        
    }

    if(indexPath.section == 1){
        
        cell.imageView.image = [UIImage imageNamed:@"svip"];
        cell.textLabel.text =@"自定义墙纸";
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    

        
    }if (indexPath.section == 2) {
        
        UILabel *title = [[UILabel alloc]initWithFrame:CGRectMake(11, 17, 100, 20)];
        
        title.text = @"最新上线";
        
        
        UIButton *btn1 = [UIButton buttonWithType:UIButtonTypeCustom];
        
        btn1.frame = CGRectMake(11, 50, 110, 200);
        
        [btn1 setBackgroundImage:[UIImage imageNamed:@"cell.png"] forState:UIControlStateNormal];
        [btn1 addTarget:self action:@selector(btn1) forControlEvents:UIControlEventTouchUpInside];
        
        
        
        
        UIButton *btn2 = [UIButton buttonWithType:UIButtonTypeCustom];
        
        btn2.frame = CGRectMake(132, 50, 110, 200);
        
        [btn2 setBackgroundImage:[UIImage imageNamed:@"背景1.jpg"] forState:UIControlStateNormal];
        [btn2 addTarget:self action:@selector(btn2) forControlEvents:UIControlEventTouchUpInside];
       
        
        UIButton *btn3 = [UIButton buttonWithType:UIButtonTypeCustom];
        
        btn3.frame = CGRectMake(253, 50, 110, 200);
        
        [btn3 setBackgroundImage:[UIImage imageNamed:@"bat.jpg"] forState:UIControlStateNormal];
        [btn3 addTarget:self action:@selector(btn3) forControlEvents:UIControlEventTouchUpInside];
        


        
        UILabel *a = [[UILabel alloc]initWithFrame:CGRectMake(11, 260, 100, 15)];
        a.font = [UIFont fontWithName:nil size:14];
        a.text = @"淡雅青竹";
        
        UILabel *b = [[UILabel alloc]initWithFrame:CGRectMake(132, 260, 100, 15)];
        b.font = [UIFont fontWithName:nil size:14];
        b.text = @"蓝天白云";
        
        UILabel *c = [[UILabel alloc]initWithFrame:CGRectMake(253, 260, 100, 15)];
        c.font = [UIFont fontWithName:nil size:14];
        c.text = @"暗夜蝙蝠";
        
        
        [cell addSubview:title];
        [cell addSubview:btn1];
        [cell addSubview:btn2];
        [cell addSubview:btn3];
        [cell addSubview:a];
        [cell addSubview:b];
        [cell addSubview:c];
        
        
    }if (indexPath.section == 3) {
        
        UILabel *more = [[UILabel alloc]initWithFrame:CGRectMake(110, 0, 150, 30)];
        more.font = [UIFont fontWithName:nil size:20];
        more.textColor = [UIColor grayColor];
        more.text = @"更多敬请期待";

        cell.backgroundColor = [UIColor clearColor];
        self.tableView.separatorStyle = UITableViewCellSelectionStyleNone;
        [cell addSubview:more];
        
    }
    
        return cell;
}


-(void)btn1 {
    
    [self change:@"cell.png"];
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:nil message:@"壁纸设置完成" delegate:nil cancelButtonTitle:@"好的" otherButtonTitles:nil, nil];
    [alert show];
    
}

-(void)btn2 {
    
    [self change:@"背景1.jpg"];
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:nil message:@"壁纸设置完成" delegate:nil cancelButtonTitle:@"好的" otherButtonTitles:nil, nil];
    [alert show];

}

-(void)btn3 {
    
    [self change:@"bat.jpg"];
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:nil message:@"壁纸设置完成" delegate:nil cancelButtonTitle:@"好的" otherButtonTitles:nil, nil];
    [alert show];

}



-(void)change:(NSString *)pic {
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    UIImage *image = [UIImage imageNamed:pic];
    
    NSData *imageData = UIImageJPEGRepresentation(image, 100);
    
    [defaults setObject:imageData forKey:@"wall"];
    
    [defaults synchronize];

}



-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 1) {
        
        CustomViewController *custom = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"custom"];
        
        [self.navigationController pushViewController:custom animated:YES];
        
        self.tabBarController.tabBar.hidden = YES;
        
        self.navigationController.navigationBarHidden = NO;
        
    }

}



@end
