//
//  YYBuyIntoViewController.m
//  JJStockView
//
//  Created by g on 2019/2/24.
//  Copyright © 2019 Jezz. All rights reserved.
//

#import "YYBuyIntoViewController.h"
#import "YYBuyintoStockModel.h"
#import "XMGSqliteModelTool.h"

@interface YYBuyIntoViewController ()
@property (weak, nonatomic) IBOutlet UILabel *stockNameID;
@property (weak, nonatomic) IBOutlet UITextView *buyDecisionComment;
@property (weak, nonatomic) IBOutlet UITextField *TargetPrice;
@property (weak, nonatomic) IBOutlet UITextField *pre_sellTime;
@property (weak, nonatomic) IBOutlet UITextField *buyIntoTime;

@end

@implementation YYBuyIntoViewController
- (IBAction)save:(id)sender {
    
    YYBuyintoStockModel *buyM = [[YYBuyintoStockModel alloc] init];
    buyM.buyTime = self.buyIntoTime.text;//[NSDate date];//self.buyIntoTime.text;
    buyM.bond_id = self.stockModel.bond_id;
    buyM.bond_nm = self.stockModel.bond_nm;
    buyM.TargetPrice = self.TargetPrice.text;
    buyM.preSellTime = self.pre_sellTime.text;[NSDate date];//self.pre_sellTime.text;
    buyM.buyDecisionComment = self.buyDecisionComment.text;
    
    
    
    
    [XMGSqliteModelTool saveOrUpdateModel:buyM uid:@"mybuy"];//Mystock
    
    
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (IBAction)back:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.stockNameID.text = [NSString stringWithFormat:@"%@   %@",self.stockModel.bond_nm,self.stockModel.bond_id];
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
