
//

#import "HNNoPasteTextField.h"

@implementation HNNoPasteTextField

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.autocorrectionType = UITextAutocorrectionTypeNo;
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didEnterBackground) name:UIApplicationDidEnterBackgroundNotification object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didBecomeActive) name:UIApplicationDidBecomeActiveNotification object:nil];
    }
    return self;
}

-(void)didBecomeActive{
    self.hidden = NO;
}

-(void)didEnterBackground{
    self.hidden = YES;
}

- (BOOL)canPerformAction:(SEL)action withSender:(id)sender
{
    if (action == @selector(copy:)) { //禁止复制
        return NO;
    }
    if (action == @selector(cut:)) {  //禁止剪切
        return NO;
    }
    
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wundeclared-selector"
    if (action == @selector(_share:)) {  //禁止共享
        return NO;
    }
#pragma clang diagnostic pop
    if (action == @selector(select:)) {  //禁止选择
        return NO;
    }
    if (action == @selector(selectAll:)) {  //禁止全选
        return NO;
    }
    return [super canPerformAction:action withSender:sender];
}
    
@end
