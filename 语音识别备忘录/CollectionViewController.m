//
//  CollectionViewController.m
//  语音识别备忘录
//
//  Created by Fay on 15/8/3.
//  Copyright (c) 2015年 Fay. All rights reserved.
//

#import "CollectionViewController.h"

@interface CollectionViewController ()<UICollectionViewDelegateFlowLayout,UICollectionViewDelegate,UICollectionViewDataSource>
{
    
    NSArray *_colors;
}

@end

@implementation CollectionViewController

static NSString * const reuseIdentifier = @"Cell";

-(void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    
    NSString *color = [[NSUserDefaults standardUserDefaults] objectForKey:@"color"];

    [self.navigationController.navigationBar setBarTintColor:[self colorFromHexString:color]];
    
    
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations
    // self.clearsSelectionOnViewWillAppear = NO;
    
    self.title = @"个性皮肤";
    
    // Register cell classes
    [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:reuseIdentifier];
    
    //self.collectionView.backgroundColor = [UIColor whiteColor];
    
    // Do any additional setup after loading the view.
    
    NSString *path = [[NSBundle mainBundle] pathForResource:@"colors_pantone.plist" ofType:nil];
    
    NSMutableArray *data = [[NSMutableArray alloc]initWithContentsOfFile:path];
    
    NSMutableArray * zero = data[0];
    
    NSMutableArray *color = [NSMutableArray array];
    
    for (NSDictionary *dic in zero) {
        
        [color addObject:[dic objectForKey:@"hash"]];
        
    }
    
    _colors = [[color reverseObjectEnumerator] allObjects];
    
    NSLog(@"%@",_colors);
    
    
    
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






-(void)didReceiveMemoryWarning {
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

#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {

    return [_colors count];
}





- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    
    
    cell.backgroundColor = [self colorFromHexString:_colors[indexPath.row]];

    return cell;
}



-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
   // UICollectionViewCell *cell = [collectionView cellForItemAtIndexPath:indexPath];
    
    //cell.backgroundColor = [UIColor whiteColor];
    
    self.navigationController.navigationBar.barTintColor = [self colorFromHexString:_colors[indexPath.row]];
    
    
    [self.tabBarController.tabBar setBarTintColor:[self colorFromHexString:_colors[indexPath.row]]];
    
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    
    NSString *savaColor = _colors[indexPath.row];
    
    [defaults setObject:savaColor forKey:@"color"];
   
    
    [defaults synchronize];

   
    NSLog(@"%ld",indexPath.row);
    
}



-(BOOL)collectionView:(UICollectionView *)collectionView shouldHighlightItemAtIndexPath:(NSIndexPath *)indexPath {
    
    return YES;
}


// Uncomment this method to specify if the specified item should be selected
- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}




@end
