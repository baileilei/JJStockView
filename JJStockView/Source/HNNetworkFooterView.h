//
//  HNNetworkFooterView.h
//  HomeNetwork
//
//  Created by chinasoftinc on 2018/9/22.
//  Copyright © 2018年 HUAWEI. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SMEditLabel.h"

@class HNToolModel;
//推荐网络工具点击事件
typedef void(^ToolButtonClick)(HNToolModel *tool);

NS_ASSUME_NONNULL_BEGIN

@interface HNNetworkFooterView : UIView

@property (nonatomic,weak) SMEditLabel *titleLable;
//推荐网络工具点击事件block
@property(nonatomic, copy) ToolButtonClick toolButtonClick;

@end

NS_ASSUME_NONNULL_END
