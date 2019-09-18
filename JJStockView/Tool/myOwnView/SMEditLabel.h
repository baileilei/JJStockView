//
//  SMEditLabel.h
//  smartWiFi
//
//  Created by smart-wift on 2019/9/18.
//  Copyright © 2019 Smart Wi-Fi. All rights reserved.
//
#import <UIKit/UIKit.h>


typedef enum : NSUInteger {
    CopyLabel,
    CopyAndPasteLabel
} CopyLabelStatus;

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SMEditLabel : UILabel

@property (nonatomic,assign) CopyLabelStatus lableType;
@end

NS_ASSUME_NONNULL_END
