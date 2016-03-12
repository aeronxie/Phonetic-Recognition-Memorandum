//
//  FallViewController.m
//  语音识别备忘录
//
//  Created by Fay on 15/8/5.
//  Copyright (c) 2015年 Fay. All rights reserved.
//

#import "FallViewController.h"
#import "CollectionViewCell.h"
#import "LeisureViewController.h"
#import "ReadViewController.h"
#import "ShoppingViewController.h"
#import "MovieViewController.h"

@interface FallViewController ()<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>
@property (weak, nonatomic) IBOutlet UICollectionView *collection;
@property (nonatomic,strong)NSArray *items;

@end

@implementation FallViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.collection.delegate = self;
    self.collection.dataSource = self;
    self.collection.showsVerticalScrollIndicator = NO;
    _items = @[@"旅游",@"阅读",@"电影",@"购物"];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    
    return 1;
}

//-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
//    
//    return CGSizeMake(80,80);
//    
//}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return 4;
}


-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsMake(0, 24, 0, 5);
    
}



-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    CollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    
    NSString *name = [NSString stringWithFormat:@"100303%ld",indexPath.row+1];

        
    cell.btnIcon.image = [UIImage imageNamed:name];
    
    cell.label.text =_items[indexPath.row];
    
    return cell;
    
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.row == 0) {
        
        LeisureViewController *leisure = [[LeisureViewController alloc]init];
        
        [self.navigationController pushViewController:leisure animated:YES];
        
        
        self.navigationController.navigationBarHidden = NO;

        
        
    }else if (indexPath.row == 1) {
        
        ReadViewController *read = [[ReadViewController alloc]init];
        
        [self.navigationController pushViewController:read animated:YES];
        
        self.navigationController.navigationBarHidden = NO;

    }else if (indexPath.row == 2){
        
        MovieViewController *movie = [[MovieViewController alloc]init];
        
        [self.navigationController pushViewController:movie animated:YES];
        
        self.navigationController.navigationBarHidden = NO;

        
    }else{
        
        ShoppingViewController *shop = [[ShoppingViewController alloc]init];
        
        [self.navigationController pushViewController:shop animated:YES];
        
        self.navigationController.navigationBarHidden = NO;

        
    }
    
    
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
