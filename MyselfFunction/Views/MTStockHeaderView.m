//
//  MTFoodHeaderView.m
//  MT_waimai[007]
//
//  Created by HM on 16/8/7.
//  Copyright © 2016年 HM. All rights reserved.
//

#import "MTStockHeaderView.h"
#import "Masonry.h"

@interface MTStockHeaderView ()

/**
 *  显示组标题的label
 */
@property (weak, nonatomic) UILabel *lbl;

@end

@implementation MTStockHeaderView

#pragma mark - 初始化的方法!
- (instancetype)initWithReuseIdentifier:(nullable NSString *)reuseIdentifier {

    if (self = [super initWithReuseIdentifier:reuseIdentifier]) {
        [self setupUI];
    }
    return self;
    
}

#pragma mark - 设置数据
- (void)setHeaderTitle:(NSString *)headerTitle {

    _headerTitle = headerTitle;
    
    _lbl.text = headerTitle;
}


#pragma mark - 搭建界面
- (void)setupUI {
    
//    self.contentView.backgroundColor = [UIColor cz_colorWithHex:0xf8f8f8];
    
    // 添加label展示文字
//    UILabel *lbl = [UILabel cz_labelWithText:@"销量排行" fontSize:12 color:[UIColor cz_colorWithHex:0x404040]];
    UILabel *lbl = [[UILabel alloc] init];
    lbl.font = [UIFont systemFontOfSize:12];
    
    [self.contentView addSubview:lbl];
    
    [lbl mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(10);
        make.centerY.equalTo(self.contentView);
        
    }];
    
    // 记录
    _lbl = lbl;
    
    
    
}

@end
