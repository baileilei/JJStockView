//
//  MTCategoryCell.m
//  MT_waimai[007]
//
//  Created by HM on 16/8/7.
//  Copyright © 2016年 HM. All rights reserved.
//

#import "MTCategoryCell.h"
//#import "MTShopCategory.h"
#import "YYSelfDefineCategoryStock.h"
#import "Masonry.h"


@implementation MTCategoryCell

#pragma mark - 设置基本信息
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        [self setupUI];
    }
    return self;
}

#pragma mark - 搭建界面
- (void)setupUI {
    
    // 1.设置默认的背景颜色
//    self.contentView.backgroundColor = [UIColor cz_colorWithHex:0xf8f8f8];
    self.textLabel.backgroundColor = [UIColor clearColor];
    
    // 2.设置标题的颜色,大小,行数
//    self.textLabel.textColor = [UIColor cz_colorWithHex:0x464646];
    self.textLabel.font = [UIFont systemFontOfSize:13];
    self.textLabel.numberOfLines = 2;
    
    // 3.设置选中的背景
    UIView *selectBg = [[UIView alloc] init];
//    selectBg.backgroundColor = [UIColor cz_colorWithHex:0xffffff];
    
    self.selectedBackgroundView = selectBg;
    
    // 4.黄色的竖线
    UIView *vLine = [[UIView alloc] init];
    vLine.backgroundColor = [UIColor brownColor];
    
    [selectBg addSubview:vLine];
    
    [vLine mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.width.mas_equalTo(4);
        make.left.centerY.equalTo(selectBg);
        make.height.mas_equalTo(28);
    }];
    
    // 5.添加自己的分割线
    UIView *separatorLine = [[UIView alloc] init];
    separatorLine.backgroundColor = [UIColor grayColor];
    
    [self.contentView addSubview:separatorLine];
    
    [separatorLine mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.bottom.right.equalTo(self.contentView);
        make.height.mas_equalTo(1);
    }];
    
}

#pragma mark - 设置数据
- (void)setCategoryModel:(YYSelfDefineCategoryStock *)categoryModel {

    _categoryModel = categoryModel;
    
    self.textLabel.text = categoryModel.name;

}

@end
