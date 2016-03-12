//
//  MainViewController.m
//  语音识别备忘录
//
//  Created by Fay on 15/7/27.
//  Copyright (c) 2015年 Fay. All rights reserved.
//

#import "MainViewController.h"
#import "AddNoteViewController.h"
#import "DetailViewController.h"

@interface MainViewController ()<UITableViewDataSource,UITableViewDelegate,UISearchDisplayDelegate,UISearchControllerDelegate>

@property NSMutableArray *filteredNoteArray;//过滤数组
@property UISearchBar *bar;//搜索条
@property UISearchDisplayController *searchCtrl;//搜索控制
@property (nonatomic,strong)NSMutableArray *dateTemp;
@property (nonatomic,strong)NSMutableArray *noteTemp;
@property (nonatomic,strong)NSMutableArray *countDateTemp;
@end

@implementation MainViewController

-(void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
   //储存对象（单例）
    self.noteArray  = [[NSUserDefaults standardUserDefaults] objectForKey:@"note"];
    
    self.noteTemp = [NSMutableArray arrayWithArray:self.noteArray];

    self.dateArray = [[NSUserDefaults standardUserDefaults] objectForKey:@"date"];
    
    self.dateTemp = [NSMutableArray arrayWithArray:self.dateArray];
 
    self.countDateArray = [[NSUserDefaults standardUserDefaults] objectForKey:@"countdate"];
    
    self.countDateTemp = [NSMutableArray arrayWithArray:self.countDateArray];
    
    [self.tableView reloadData];
    
    
    //取出保存的主题颜色
    NSString *color = [[NSUserDefaults standardUserDefaults] objectForKey:@"color"];
    
    
    [self.navigationController.navigationBar setBarTintColor:[self colorFromHexString:color]];

    [self.tabBarController.tabBar setBarTintColor:[self colorFromHexString:color]];
    
    
    //取出保存的墙纸
    
    NSData *imageData = [[NSUserDefaults standardUserDefaults] dataForKey:@"wall"];
    
    UIImage *image = [UIImage imageWithData:imageData];
    
    
    UIImageView *iamge = [[UIImageView alloc]initWithImage:image];
    
    [self.tableView setBackgroundView:iamge];
    

}


- (void)viewDidLoad {
    [super viewDidLoad];
   
    
    //初始化搜索框
    _bar = [[UISearchBar alloc]initWithFrame:CGRectMake(0, 0, self.tableView.bounds.size.width, 44)];
    
      
    [_bar sizeToFit];
    
    _bar.placeholder = @"搜索";
    
    _searchCtrl = [[UISearchDisplayController alloc]initWithSearchBar:_bar contentsController:self];

    _searchCtrl.delegate = self;
    
    _searchCtrl.searchResultsDataSource = self;
    
    _searchCtrl.searchResultsDelegate = self;
    
    self.tableView.tableHeaderView = _bar;
    
        
    //设置导航栏颜色为白色
    [self navigationController].navigationBar.tintColor = [UIColor whiteColor];

    self.hidesBottomBarWhenPushed = NO;
    
    //设置tableview背景图片
    
   
    UIImageView *iamge = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"背景1.jpg"]];
    
    [self.tableView setBackgroundView:iamge];
    
    [self.tabBarController.tabBar setTintColor:[UIColor whiteColor]];
    
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


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    
    if(tableView == self.searchDisplayController.searchResultsTableView) {
        
        return [_filteredNoteArray count];
        
    }else {
        
        return [self.noteTemp count];
        
    }

}


//每行显示的内容
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil) {
        
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellIdentifier];
    }
    
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    NSString *note = nil;
    
    if (tableView == self.searchDisplayController.searchResultsTableView) {
        
        note = [_filteredNoteArray objectAtIndex:indexPath.row];
        
    }else if (tableView == self.tableView){
        
        note = [self.noteArray objectAtIndex:indexPath.row];
        
    };
    
    NSString *date = [_dateArray objectAtIndex:indexPath.row];
    
    NSUInteger charnum = [note length];
    
    if (charnum <22) {
        
        cell.textLabel.text = note;
    
    }else{
        
        cell.textLabel.text = [[note substringToIndex:18] stringByAppendingString:@"..."];
        
    }
    cell.detailTextLabel.text = date;
    
    cell.detailTextLabel.font = [UIFont systemFontOfSize:10];
    
 
    cell.backgroundColor = [UIColor clearColor];
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    
    return cell;
    
}




//选中某一行
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
  
   DetailViewController *detail = [[DetailViewController alloc]initWithNibName:nil bundle:nil];
    
    NSInteger row = [indexPath row];
    
    detail.index = row;
    
    [self.navigationController pushViewController:detail animated:YES];

    
}



-(BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return YES;
}


-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
 
        
        [self.noteTemp removeObjectAtIndex:indexPath.row];
        [self.dateTemp removeObjectAtIndex:indexPath.row];
        [self.countDateTemp removeObjectAtIndex:indexPath.row];
        
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];

        [[NSUserDefaults standardUserDefaults] setObject:self.noteTemp forKey:@"note"];
        [[NSUserDefaults standardUserDefaults] setObject:self.dateTemp forKey:@"date"];
        [[NSUserDefaults standardUserDefaults] setObject:self.countDateTemp forKey:@"countdate"];
        
        [self.tableView reloadData];
    }
    
    
}



#pragma mark UISearchDisplayDelegate

//搜索过滤
-(BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchString:(NSString *)searchString

{
    [_filteredNoteArray removeAllObjects];
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF contains[cd] %@",searchString];
    
    NSArray *tempArray = [_noteArray filteredArrayUsingPredicate:predicate];
    
    _filteredNoteArray = [NSMutableArray arrayWithArray:tempArray];
    
    return YES;
    
}



- (NSMutableArray *)noteArray {
    if (_noteArray == nil) {
        _noteArray = [NSMutableArray array];
        
    }
    return _noteArray;
}

- (NSMutableArray *)dateArray {
    if (_dateArray == nil) {
        _dateArray = [NSMutableArray array];
      
    }
    return _dateArray;
}


@end
