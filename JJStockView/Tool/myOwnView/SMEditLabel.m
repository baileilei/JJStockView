//
//  SMEditLabel.m
//  smartWiFi
//
//  Created by smart-wift on 2019/9/18.
//  Copyright © 2019 Smart Wi-Fi. All rights reserved.
//

#import "SMEditLabel.h"

@implementation SMEditLabel


-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self attachTapHandler];
    }
    return self;
}

-(void)attachTapHandler{
    self.userInteractionEnabled = YES;
    UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(tap:)];
    [self addGestureRecognizer:longPress];
}


-(void)tap:(UIGestureRecognizer *)sender{
    if (sender.state == UIGestureRecognizerStateBegan) {
        [self becomeFirstResponder];
        [[UIMenuController sharedMenuController] setTargetRect:self.frame inView:self.superview];
        [[UIMenuController sharedMenuController] setMenuVisible:YES animated:YES];
    }
}


-(BOOL)canBecomeFirstResponder{
    return YES;
}

-(BOOL)canPerformAction:(SEL)action withSender:(id)sender{
    switch (self.lableType) {
        case CopyLabel:
            return (action == @selector(copy:));
            break;
            
        case CopyAndPasteLabel:
            if (action == @selector(copy:)) {
                return (action == @selector(copy:));
            }else{
                return (action == @selector(paste:));
            }
            break;
            
        default:
            return NO;
            break;
    }
}

-(void)copy:(id)sender{
    UIPasteboard *board = [UIPasteboard generalPasteboard];
    board.string = self.text;
}

-(void)paste:(id)sender{
    UIPasteboard *board = [UIPasteboard generalPasteboard];
    board.string = self.text;
}

@end
