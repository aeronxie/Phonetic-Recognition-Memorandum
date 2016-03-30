//
//  CollectionViewController.m
//  语音识别备忘录
//
//  Created by Fay on 15/8/3.
//  Copyright (c) 2015年 Fay. All rights reserved.
//

#import "CollectionViewController.h"
#import "UIColor+Hash.h"

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

    [self.navigationController.navigationBar setBarTintColor:[UIColor colorFromHexString:color]];
    
    
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
    

}



#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {

    return [_colors count];
}





- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    
    
    cell.backgroundColor = [UIColor colorFromHexString:_colors[indexPath.row]];

    return cell;
}



-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    
    self.navigationController.navigationBar.barTintColor = [UIColor colorFromHexString:_colors[indexPath.row]];
    
    
    [self.tabBarController.tabBar setBarTintColor:[UIColor colorFromHexString:_colors[indexPath.row]]];
    
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    
    NSString *savaColor = _colors[indexPath.row];
    NSLog(@"-------%@-------",savaColor);
    
    [defaults setObject:savaColor forKey:@"color"];

    [defaults synchronize];
    
}



-(BOOL)collectionView:(UICollectionView *)collectionView shouldHighlightItemAtIndexPath:(NSIndexPath *)indexPath {
    
    return YES;
}


// Uncomment this method to specify if the specified item should be selected
- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}




@end
