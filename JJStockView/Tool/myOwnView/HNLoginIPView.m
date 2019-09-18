
//

#import "HNLoginIPView.h"
#import "HMTMasonry.h"

//  国际化
#define LocalizedStringForkey(key)  [[NSBundle mainBundle] localizedStringForKey:key value:@"" table:nil]


@interface HNLoginIPView()<UITextFieldDelegate>

@property(nonatomic, strong)UITextField  *ipField;

@end

@implementation HNLoginIPView

- (void)creatAltWithAltTile:(NSString *)title content:(NSString *)content{
    _view = [[UIView alloc] init];
    _view.backgroundColor = [UIColor whiteColor];
    UILabel *altTitleLabel = [[UILabel alloc] init];
    altTitleLabel.text = title;
    [altTitleLabel setTextAlignment:NSTextAlignmentCenter];
    [altTitleLabel setFont:[UIFont systemFontOfSize:16]];
    [altTitleLabel setTextColor:[UIColor blackColor]];
    [altTitleLabel setFrame:CGRectMake(0, 5, _altwidth, 30)];
    [_view addSubview:altTitleLabel];
    
    UILabel *altContent = [[UILabel alloc] init];
    NSString *ipString = @"";
    
    if ([[NSUserDefaults standardUserDefaults] objectForKey:@"IPAddress"]) {
        ipString = [NSString stringWithFormat:@"IP:%@",[[NSUserDefaults standardUserDefaults] objectForKey:@"IPAddress"]];
    }else{//默认显示演示地址
        ipString = [NSString stringWithFormat:@"IP:%@",@"www.baidu.com"];
    }
    
    [altContent setText:ipString];
    altContent.numberOfLines = 2;
    [altContent setFont:[UIFont systemFontOfSize:12.0f]];
    [altContent setTextAlignment:NSTextAlignmentLeft];
    [altContent setTextColor:[UIColor colorWithRed:0.3f green:0.3f blue:0.3f alpha:1.0]];
    [altContent setLineBreakMode:NSLineBreakByCharWrapping];
    [_view addSubview:altContent];
    [altContent mas_makeConstraints:^(HMTMASConstraintMaker *make) {
        make.left.mas_equalTo(15);
        make.right.mas_equalTo(self.view.mas_right).offset(-10);
        make.top.mas_equalTo(altTitleLabel.mas_bottom).mas_offset(10);
        make.height.mas_equalTo(60);
    }];
    
    UITextField  *ipField = [UITextField new];
    ipField.font = [UIFont systemFontOfSize:15];
    ipField.leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 10)];
    ipField.leftViewMode = UITextFieldViewModeAlways;
    ipField.clearButtonMode = UITextFieldViewModeWhileEditing;
    ipField.borderStyle = UITextBorderStyleRoundedRect;
    ipField.keyboardType = UIKeyboardTypeASCIICapable;
    ipField.delegate = self;
    ipField.placeholder = LocalizedStringForkey(@"hint_input_server_ip");
    [self.view addSubview:ipField];
    [ipField mas_makeConstraints:^(HMTMASConstraintMaker *make) {
        make.left.mas_equalTo(altContent.mas_left);
        make.right.mas_equalTo(self.view.mas_right).offset(-10);
        make.top.mas_equalTo(altContent.mas_bottom).mas_offset(5);
        make.height.mas_equalTo(44);
    }];
    self.ipField = ipField;
    
//    self.ipField.text = [SMBaseConnect getSeverIPWithKey:@"SMK_ServerIP"];//测试用
    
    UIButton *altbtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
//    [altbtn setTitle:LocalizedStringForkey(@"ids_base_cancel") forState:UIControlStateNormal];
    [altbtn setBackgroundColor:[UIColor whiteColor]];
    [altbtn setTag:0];
    [altbtn setFrame:CGRectMake(5, 5, 50, 35)];
    [altbtn addTarget:self action:@selector(checkbtn:) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *altbut1=[UIButton buttonWithType:UIButtonTypeRoundedRect];
//    [altbut1 setTitle:LocalizedStringForkey(@"ids_base_save") forState:UIControlStateNormal];
    [altbut1 setBackgroundColor:[UIColor whiteColor]];
    [altbut1 setTag:1];
    [altbut1 setFrame:CGRectMake(_altwidth - 55, 5, 50, 35)];
    [altbut1 addTarget:self action:@selector(checkbtn:) forControlEvents:UIControlEventTouchUpInside];
    
    [_view addSubview:altbtn];
    [_view addSubview:altbut1];
    _altHeight = 180;
    
    [_view setFrame:CGRectMake(0, ([UIScreen mainScreen].bounds.size.height-_altHeight)/2-64, _altwidth , _altHeight)];
    _view.layer.masksToBounds = YES;
    _view.layer.cornerRadius  = 5;
    [self addSubview:_view];
    self.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
    self.backgroundColor = [[UIColor lightGrayColor] colorWithAlphaComponent:0.3];
    
}

#pragma Delegate
-(void)alertview:(id)altview clickbuttonIndex:(NSInteger)index
{
    [_delegate alertview:self clickbuttonIndex:index withTextField:_ipField.text];
}
#pragma SELECTOR
-(void)handleSingleTap:(UITapGestureRecognizer *)sender
{
    [self hide];
}
-(void)checkbtn:(UIButton *)sender
{
    [_delegate alertview:self clickbuttonIndex:sender.tag withTextField:_ipField.text];
}
#pragma Instance method
-(void)show
{
    [self setHidden:NO];
}
-(void)hide
{
    [_view removeFromSuperview];
    [self setHidden:YES];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self endEditing:YES];
}

- (void)textFieldDidEndEditing:(UITextField *)textField{
    [textField resignFirstResponder];
}

@end


