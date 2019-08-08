//
//  NSString+storeImagePath.m
//  JJStockView
//
//  Created by smart-wift on 2019/8/6.
//  Copyright © 2019 Jezz. All rights reserved.
//

#import "NSString+storeImagePath.h"


@implementation NSString (storeImagePath)

// 保存图片返回保存的路劲
+ (NSString *)saveImg:(UIImage *)tempImg{
    NSDate *sendDate = [NSDate date];
    NSString *currentStr = [NSString stringWithFormat:@"%ld",(long)[sendDate timeIntervalSince1970]];
    // 用时间戳作为文件名
    NSString *imgNameStr = [NSString stringWithFormat:@"%@%@",currentStr,@".jpg"];
    NSData *imgData = UIImagePNGRepresentation(tempImg);
    NSString *libraryDirectory = [NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES) firstObject];
    NSString *imgPath = [libraryDirectory stringByAppendingString:@"/PlugImage"];
    BOOL isSuccess = [[NSFileManager defaultManager] createDirectoryAtPath:imgPath withIntermediateDirectories:YES attributes:nil error:nil];
    if (isSuccess) {
        NSString *fullPath = [imgPath stringByAppendingPathComponent:[NSString stringWithFormat:@"%@/", imgNameStr]];
        if([imgData writeToFile:fullPath atomically:NO]){
            return fullPath;
        }else{
            return nil;
        }
    }else {
        return nil;
    }
}

@end
