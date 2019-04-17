//
//  YYStockViewCell.m
//  YYStockView
//
//  Created by Jezz on 2017/10/14.
//  Copyright © 2017年 StockView. All rights reserved.
//

#import "YYStockViewCell.h"
#import "YYStockScrollView.h"

@interface YYStockViewCell()<UIScrollViewDelegate>{
    @private
    UIScrollView* _rightContentScrollView;
}

@end

@implementation YYStockViewCell

- (void)dealloc{
    self.rightContentTapBlock = nil;
}

#pragma mark - Init

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setupDefaultSettings];
        [self setupView];
    }
    return self;
}

#pragma mark - Layout

- (void)layoutSubviews{
    [super layoutSubviews];
    
    self.titleView.frame = CGRectMake(0, 0, CGRectGetWidth(self.titleView.frame), CGRectGetHeight(self.titleView.frame));
    
    id tempDelegate = _rightContentScrollView.delegate;
    _rightContentScrollView.delegate = nil;//Do not send delegate message
    
    _rightContentScrollView.frame = CGRectMake(CGRectGetWidth(self.titleView.frame), 0, CGRectGetWidth(self.frame) - CGRectGetWidth(self.titleView.frame), CGRectGetHeight(self.rightContentView.frame));
    _rightContentScrollView.contentSize = CGSizeMake(CGRectGetWidth(self.rightContentView.frame), CGRectGetHeight(self.rightContentView.frame));
    
    _rightContentScrollView.delegate = tempDelegate;//Restore deleagte
}

#pragma mark - Setup

- (void)setupDefaultSettings{
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    self.backgroundColor = [UIColor whiteColor];
}

- (void)setupView{
    [self.contentView addSubview:self.rightContentScrollView];
    
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction:)];
    [self.rightContentScrollView addGestureRecognizer:tapGesture];
}

#pragma mark - Tap

- (void)tapAction:(UITapGestureRecognizer *)gesture{
    if (self.rightContentTapBlock) {
        self.rightContentTapBlock(self);
    }
}

#pragma mark - Public

- (UIScrollView*)rightContentScrollView{
    if (_rightContentScrollView != nil) {
        return _rightContentScrollView;
    }
    _rightContentScrollView = [YYStockScrollView new];
    _rightContentScrollView.canCancelContentTouches = YES;
    _rightContentScrollView.showsVerticalScrollIndicator = NO;
    _rightContentScrollView.showsHorizontalScrollIndicator = NO;
    return _rightContentScrollView;
}

- (void)setTitleView:(UIView*)titleView{
    if(_titleView){
        [_titleView removeFromSuperview];
    }
    [self.contentView addSubview:titleView];
    
    _titleView = titleView;
        
    [self setNeedsLayout];
}

- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event{
    // 1.判断下窗口能否接收事件
    if (self.userInteractionEnabled == NO || self.hidden == YES ||  self.alpha <= 0.01) return nil;
    // 2.判断下点在不在窗口上
    // 不在窗口上
    if ([self pointInside:point withEvent:event] == NO) return nil;
    // 3.从后往前遍历子控件数组
    int count = (int)self.subviews.count;
    for (int i = count - 1; i >= 0; i--)     {
        // 获取子控件
        UIView *childView = self.subviews[i];
        // 坐标系的转换,把窗口上的点转换为子控件上的点
        // 把自己控件上的点转换成子控件上的点
        CGPoint childP = [self convertPoint:point toView:childView];
        UIView *fitView = [childView hitTest:childP withEvent:event];
        if (fitView) {
            // 如果能找到最合适的view
            return fitView;
        }
    }
    // 4.没有找到更合适的view，也就是没有比自己更合适的view
    return self;
}

- (void)setRightContentView:(UIView*)contentView{
    if(_rightContentView){
        [_rightContentView removeFromSuperview];
    }
    [_rightContentScrollView addSubview:contentView];
    
    _rightContentView = contentView;
//    _rightContentView.userInteractionEnabled = NO;//点击的是button，响应的确实代理方法。
    
    [self setNeedsLayout];
}


@end
