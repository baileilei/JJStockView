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

#import "NTMonthYearPicker.h"

@interface YYBuyIntoViewController ()<UITextFieldDelegate>
{
    UIPopoverController *popupCtrl;
    NTMonthYearPicker *picker;
}
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
    
    self.buyIntoTime.delegate = self;
}

#pragma mark - UITextFieldDelegate
-(void)textFieldDidBeginEditing:(UITextField *)textField{
    if (textField  == self.buyIntoTime) {
        [self.buyIntoTime endEditing:YES];
    }
    [self showMonthPicker];
}

-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    return YES;
}


-(void)showMonthPicker
{
    picker = [[NTMonthYearPicker alloc] init];
    [picker addTarget:self action:@selector(onDatePicked:) forControlEvents:UIControlEventValueChanged];
    if( !popupCtrl.isPopoverVisible ) {
        UIView *container = [[UIView alloc] init];
        [container addSubview:picker];
        UIViewController* popupVC = [[UIViewController alloc] init];
        popupVC.view = container;
        popupCtrl = [[UIPopoverController alloc] initWithContentViewController:popupVC];
        [popupCtrl setPopoverContentSize:picker.frame.size animated:NO];
        [popupCtrl presentPopoverFromRect:CGRectMake(30,380,200,200)
                                   inView:self.buyIntoTime permittedArrowDirections:UIPopoverArrowDirectionAny
                                 animated:YES];
    }
}
- (void)onDatePicked:(UITapGestureRecognizer *)gestureRecognizer {
    NSDateFormatter *df = [[NSDateFormatter alloc] init];
    [df setDateFormat:@"MMM-yyyy"];
    NSString *dateStr = [df stringFromDate:picker.date];
//    [self.btnPolicyAnniversary setTitle:dateStr forState:UIControlStateNormal];
    self.buyIntoTime.text = dateStr;
    
    
    [df setDateFormat:@"M-yyyy"];
//    strSelectedMonthYear = [df stringFromDate:picker.date];
}

@end
