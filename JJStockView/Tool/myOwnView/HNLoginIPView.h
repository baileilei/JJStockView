
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol LoginIPViewDelegate <NSObject>
- (void)alertview:(id)altview clickbuttonIndex:(NSInteger)index withTextField:(NSString *)textField;
@end

@interface HNLoginIPView : UIView

@property(nonatomic,strong)UIView *view;
@property(nonatomic,assign)float altHeight;
@property(nonatomic,assign)float altwidth;
@property(nonatomic,weak)id<LoginIPViewDelegate>delegate;

- (void)creatAltWithAltTile:(NSString*)title content:(NSString*)content;
- (void)show;
- (void)hide;
@end

NS_ASSUME_NONNULL_END
