//
//  HNRecommendToolCell.h
//  HomeNetwork
//
//  Created by chinasoftinc on 2018/9/28.
//  Copyright © 2018年 HUAWEI. All rights reserved.
//  【smartWiFi】->【首页】-> 【推荐网络工具】-> 【推荐网络工具cell】

#import <UIKit/UIKit.h>
@class HNToolModel;
NS_ASSUME_NONNULL_BEGIN

@interface HNRecommendToolCell : UICollectionViewCell

/**
 图标
 */
@property(nonatomic, weak) UIImageView *iconImage;

/**
 名字
 */
@property(nonatomic, weak) UILabel *nameLabel;

//@property(nonatomic, strong) HNToolModel *toolModel;
@end

NS_ASSUME_NONNULL_END
