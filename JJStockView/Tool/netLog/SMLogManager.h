//
//  SMLogManager.h
//  smartWiFi
//
//  Created by Smart Wi-Fi on 2019/8/19.
//  Copyright © 2019 Smart Wi-Fi. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface SMLogManager : NSObject

+ (instancetype)sharedManager;

- (void)setDefaultLog;
- (void)clearExpiredLog;

@end

NS_ASSUME_NONNULL_END
