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

-(void)myFocusExceptionHandler:(YYBuyintoStockModel *)stock comments:(NSString *)comments;

-(void)Tool_log:(id)model comments:(NSString *)comments;

- (void)setDefaultLog;
- (void)clearExpiredLog;

@end

NS_ASSUME_NONNULL_END
