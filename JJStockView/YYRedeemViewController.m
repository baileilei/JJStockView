//
//  YYRedeemViewController.m
//  JJStockView
//
//  Created by g on 2019/4/8.
//  Copyright © 2019 Jezz. All rights reserved.
//

#import "YYRedeemViewController.h"

@interface YYRedeemViewController ()

@end

@implementation YYRedeemViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
//    self.RedeemStocks;
    self.stocks = self.RedeemStocks;
    [self.stockView reloadStockView];
}

- (void)didReceiveMemoryWarning {
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

@end
