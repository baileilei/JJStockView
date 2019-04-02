//
//  YYSerachViewController.m
//  JJStockView
//
//  Created by g on 2019/4/2.
//  Copyright © 2019 Jezz. All rights reserved.
//

#import "YYSerachViewController.h"

@interface YYSerachViewController ()<UISearchBarDelegate>

@property (weak, nonatomic) UITableView *tableView;

@end

@implementation YYSerachViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UISearchBar *searchBar = [[UISearchBar alloc] init];
    searchBar.placeholder = @"请输入名称、代码";
    searchBar.delegate = self;
    
    self.navigationItem.titleView = searchBar;
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStyleDone target:self action:@selector(back)];
    
    UITableView *tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    [self.view addSubview:tableView];
    self.tableView = tableView;
    
    UISearchController *serarchVC = [[UISearchController alloc] initWithSearchResultsController:nil];
}



#pragma mark -UISearchBarDelegate
-(void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText{
    
}



-(void)back{
    
    [self dismissViewControllerAnimated:YES completion:nil];
}




@end
