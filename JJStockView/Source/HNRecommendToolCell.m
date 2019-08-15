//
//  HNRecommendToolCell.m
//  HomeNetwork
//
//  Created by chinasoftinc on 2018/9/28.
//  Copyright © 2018年 HUAWEI. All rights reserved.
//  【smartWiFi】->【首页】-> 【推荐网络工具】-> 【推荐网络工具cell】

#import "HNRecommendToolCell.h"
//#import "HNToolModel.h"
#import "HMTMasonry/HMTMasonry.h"

//  屏幕宽度
#define SCREEN_WIDTH    [UIScreen mainScreen].bounds.size.width
#define WIDTH_PROPORTION (SCREEN_WIDTH / 540.0)


@interface HNRecommendToolCell ()



@end

@implementation HNRecommendToolCell

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self creatChildViewToRecommendToolCell];   //创建子控件
    }
    return self;
}

#pragma mark - 创建子控件
- (void)creatChildViewToRecommendToolCell {
    //1.创建图片
    UIImageView *iconImage = [[UIImageView alloc] init];
    [self.contentView addSubview:iconImage];
    [iconImage mas_makeConstraints:^(HMTMASConstraintMaker *make) {
        make.centerX.equalTo(self.contentView);
        make.top.equalTo(self.contentView).offset(37 * WIDTH_PROPORTION);
        make.width.height.mas_equalTo(60 * WIDTH_PROPORTION);
    }];
    iconImage.image = [UIImage imageNamed:@"homepage_parentControlicon"];
    self.iconImage = iconImage;
    //2.创建lable
    UILabel *nameLabel = [[UILabel alloc] init];
    [self.contentView addSubview:nameLabel];
    [nameLabel mas_makeConstraints:^(HMTMASConstraintMaker *make) {
        make.centerX.equalTo(self.contentView);
        make.top.equalTo(iconImage.mas_bottom).offset(16 * WIDTH_PROPORTION);
        make.leading.equalTo(self.contentView).offset(5);
        make.trailing.equalTo(self.contentView).offset(-5);
    }];
    nameLabel.font = [UIFont systemFontOfSize:20 * WIDTH_PROPORTION];
//    nameLabel.textColor = [UIColor CustomColorByStr:@"#212121"];
    nameLabel.numberOfLines = 0;
    nameLabel.textAlignment = NSTextAlignmentCenter;
    self.nameLabel = nameLabel;
}

- (void)setToolModel:(HNToolModel *)toolModel {
//    _toolModel = toolModel;
//    if (toolModel.isDefaultModel) {
//        self.nameLabel.text = LocalizedStringForkey(toolModel.title);;
//        self.iconImage.image = [UIImage imageNamed:toolModel.icon];
//    }else{
//        self.nameLabel.text = toolModel.title;
//        self.iconImage.image = [UIImage imageWithContentsOfFile:toolModel.icon];
//    }

}

@end
