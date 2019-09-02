//
//  SMLogManager.h
//  smartWiFi
//
//  Created by Smart Wi-Fi on 2019/8/19.
//  Copyright © 2019 Smart Wi-Fi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YYStockModel.h"
#import "YYBuyintoStockModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface SMLogManager : NSObject

+ (instancetype)sharedManager;

-(void)myFocusExceptionHandler:(YYStockModel *)stock count:(NSInteger)count;

//待发转债
-(void)myFocusExceptionHandler:(YYBuyintoStockModel *)stock comments:(NSString *)comments;

//planName  targetStockName  currentStockPrice  whenToVerify:
//whenToVerify:     BuyDecisionComment    TargetPrice
-(void)Tool_logPlanName:(NSString *)planName targetStockName:(NSString *)targetStockName currentStockPrice:(NSString *)currentStockPrice whenToVerify:(NSString *)whenToVerify comments:(NSString *)comments;

- (void)setDefaultLog;
- (void)clearExpiredLog;

@end

NS_ASSUME_NONNULL_END
