//
//  SMLogManager.m
//  smartWiFi
//
//  Created by Smart Wi-Fi on 2019/8/19.
//  Copyright © 2019 Smart Wi-Fi. All rights reserved.
// 将count在txt中输出！  以及关心的信息！！！ 定制的消息。
// 

#import "SMLogManager.h"
#import <UIKit/UIKit.h>



@implementation SMLogManager

+ (instancetype)sharedManager {
    static SMLogManager *logManger = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        logManger = [[self alloc] init];
    });
    return logManger;
}

-(void)Tool_logPlanName:(NSString *)planName targetStockName:(NSString *)targetStockName currentStockPrice:(NSString *)currentStockPrice currentBondPrice:(NSString *)currentBondPrice whenToVerify:(NSString *)whenToVerify comments:(NSString *)comments{
    //将crash日志保存到Document目录下的Log文件夹下
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES);
    NSString *logDirectory = [[paths objectAtIndex:0] stringByAppendingPathComponent:@"FocusLog"];
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if (![fileManager fileExistsAtPath:logDirectory]) {
        [fileManager createDirectoryAtPath:logDirectory  withIntermediateDirectories:YES attributes:nil error:nil];
    }
    
    NSString *logFilePath = [logDirectory stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.txt",planName]];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"]];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSString *dateStr = [formatter stringFromDate:[NSDate date]];
    
    
    NSString *crashString = [NSString stringWithFormat:@"<- %@ ->[ Uncaught Exception ]\r\nName: %@, [Price: %@\r\n bondPrice:%@ whenToVerify == %@]\r\ncomments == %@[ Fe Symbols End ]\r\n\r\n", dateStr, targetStockName, currentStockPrice, currentBondPrice,whenToVerify,comments];
    
    //把错误日志写到文件中
    if (![fileManager fileExistsAtPath:logFilePath]) {
        [crashString writeToFile:logFilePath atomically:YES encoding:NSUTF8StringEncoding error:nil];
    } else {
        NSFileHandle *readFile = [NSFileHandle fileHandleForReadingAtPath:logFilePath];
        NSData *currentData = [readFile readDataToEndOfFile];
        NSString *currentStr = [[NSString alloc] initWithData:currentData encoding:NSUTF8StringEncoding];
        if ([currentStr containsString:[dateStr substringToIndex:@"yyyy-MM-dd".length] ] && [currentStr containsString:targetStockName]) {
            NSLog(@"dateStr  已打印哈哈");
            return;
        }
        
        NSFileHandle *outFile = [NSFileHandle fileHandleForWritingAtPath:logFilePath];
        
        [outFile seekToEndOfFile];
        [outFile writeData:[crashString dataUsingEncoding:NSUTF8StringEncoding]];
        [outFile closeFile];
    }

}

-(void)myFocusExceptionHandler:(YYBuyintoStockModel *)stock comments:(NSString *)comments{
    
    //将crash日志保存到Document目录下的Log文件夹下
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES);
    NSString *logDirectory = [[paths objectAtIndex:0] stringByAppendingPathComponent:@"FocusLog"];
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if (![fileManager fileExistsAtPath:logDirectory]) {
        [fileManager createDirectoryAtPath:logDirectory  withIntermediateDirectories:YES attributes:nil error:nil];
    }
    
    NSString *logFilePath = [logDirectory stringByAppendingPathComponent:@"lowInElement-willBond.txt"];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"]];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSString *dateStr = [formatter stringFromDate:[NSDate date]];
    
    NSString *crashString = [NSString stringWithFormat:@"<- %@ ->[ Uncaught Exception ]\r\nName: %@, Reason: %@\r\n[ count == ]\r\n%@[ Fe Symbols End ]\r\n\r\n", dateStr, stock.stock_nm, stock.price, comments];
    
    //把错误日志写到文件中
    if (![fileManager fileExistsAtPath:logFilePath]) {
        [crashString writeToFile:logFilePath atomically:YES encoding:NSUTF8StringEncoding error:nil];
    } else {
        NSFileHandle *outFile = [NSFileHandle fileHandleForWritingAtPath:logFilePath];
        [outFile seekToEndOfFile];
        [outFile writeData:[crashString dataUsingEncoding:NSUTF8StringEncoding]];
        [outFile closeFile];
    }
}


#pragma mark - NSLog Save
-(void)myFocusExceptionHandler:(YYStockModel *)stock count:(NSInteger)count
{
    NSLog(@"myFocusExceptionHandler Begin\r\n");
    
    NSString *name = stock.stock_nm;
    
    NSMutableString *strSymbols = [[NSMutableString alloc] init]; //将调用栈拼成输出日志的字符串
    
    //将crash日志保存到Document目录下的Log文件夹下
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES);
    NSString *logDirectory = [[paths objectAtIndex:0] stringByAppendingPathComponent:@"FocusLog"];
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if (![fileManager fileExistsAtPath:logDirectory]) {
        [fileManager createDirectoryAtPath:logDirectory  withIntermediateDirectories:YES attributes:nil error:nil];
    }
    
    NSString *logFilePath = [logDirectory stringByAppendingPathComponent:@"lowInElement.txt"];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"]];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSString *dateStr = [formatter stringFromDate:[NSDate date]];
    
    NSString *crashString = [NSString stringWithFormat:@"<- %@ ->[ Uncaught Exception ]\r\nName: %@, Reason: %@\r\n[ count == ]\r\n%ld[ Fe Symbols End ]\r\n\r\n", dateStr, name, stock.price, (long)count];
    
    //把错误日志写到文件中
    if (![fileManager fileExistsAtPath:logFilePath]) {
        [crashString writeToFile:logFilePath atomically:YES encoding:NSUTF8StringEncoding error:nil];
    } else {
        NSFileHandle *outFile = [NSFileHandle fileHandleForWritingAtPath:logFilePath];
        NSData *currentData = [outFile readDataToEndOfFile];
        NSString *currentStr = [[NSString alloc] initWithData:currentData encoding:NSUTF8StringEncoding];
        if ([currentStr containsString:[dateStr substringToIndex:@"yyyy-MM-dd".length]]) {
            NSLog(@"dateStr  已打印哈哈");
            return;
        }
        [outFile seekToEndOfFile];
        [outFile writeData:[crashString dataUsingEncoding:NSUTF8StringEncoding]];
        [outFile closeFile];
    }
    
    NSLog(@"myFocusExceptionHandler End\r\n");
}


#pragma mark - NSLog Save
void UncaughtExceptionHandler(NSException *exception)
{
    NSLog(@"UncaughtExceptionHandler Begin\r\n");
    
    NSString *name = [exception name];
    NSString *reason = [exception reason];
    NSArray *symbols = [exception callStackSymbols]; // 异常发生时的调用栈
    
    NSMutableString *strSymbols = [[NSMutableString alloc] init]; //将调用栈拼成输出日志的字符串
    for (NSString* item in symbols){
        [strSymbols appendString: item];
        [strSymbols appendString: @"\r\n"];
    }
    
    //将crash日志保存到Document目录下的Log文件夹下
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES);
    NSString *logDirectory = [[paths objectAtIndex:0] stringByAppendingPathComponent:@"Log"];
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if (![fileManager fileExistsAtPath:logDirectory]) {
        [fileManager createDirectoryAtPath:logDirectory  withIntermediateDirectories:YES attributes:nil error:nil];
    }
    
    NSString *logFilePath = [logDirectory stringByAppendingPathComponent:@"UncaughtException.txt"];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"]];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSString *dateStr = [formatter stringFromDate:[NSDate date]];
    
    NSString *crashString = [NSString stringWithFormat:@"<- %@ ->[ Uncaught Exception ]\r\nName: %@, Reason: %@\r\n[ Fe Symbols Start ]\r\n%@[ Fe Symbols End ]\r\n\r\n", dateStr, name, reason, strSymbols];
    
    //把错误日志写到文件中
    if (![fileManager fileExistsAtPath:logFilePath]) {
        [crashString writeToFile:logFilePath atomically:YES encoding:NSUTF8StringEncoding error:nil];
    } else {
        NSFileHandle *outFile = [NSFileHandle fileHandleForWritingAtPath:logFilePath];
        [outFile seekToEndOfFile];
        [outFile writeData:[crashString dataUsingEncoding:NSUTF8StringEncoding]];
        [outFile closeFile];
    }
    
    NSLog(@"UncaughtExceptionHandler End\r\n");
}

- (void)redirectNSLogToDocumentFolder
{
    //如果已经连接Xcode调试则不输出到文件
    if(isatty(STDOUT_FILENO)) {
        return;
    }
    
    UIDevice *device = [UIDevice currentDevice];
    if([[device model] hasSuffix:@"Simulator"]){ //在模拟器不保存到文件中
        return;
    }
    
    //将NSlog打印信息保存到Document目录下的Log文件夹下
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *logDirectory = [[paths objectAtIndex:0] stringByAppendingPathComponent:@"Log"];
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    BOOL fileExists = [fileManager fileExistsAtPath:logDirectory];
    if (!fileExists) {
        [fileManager createDirectoryAtPath:logDirectory withIntermediateDirectories:YES attributes:nil error:nil];
    }
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"]];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"]; //每次启动后都保存一个新的日志文件中
    NSString *dateStr = [formatter stringFromDate:[NSDate date]];
    NSString *logFilePath = [logDirectory stringByAppendingFormat:@"/%@.log",dateStr];
    
    //将log输入到文件
    freopen([logFilePath cStringUsingEncoding:NSASCIIStringEncoding], "a+", stdout);
    freopen([logFilePath cStringUsingEncoding:NSASCIIStringEncoding], "a+", stderr);
}

+ (NSDate*)getCurrDate{
    NSDate *date = [NSDate date];
    NSTimeZone *zone = [NSTimeZone systemTimeZone];
    NSInteger interval = [zone secondsFromGMTForDate: date];
    NSDate *localeDate = [date dateByAddingTimeInterval: interval];
    return localeDate;
}

#pragma mark -
- (void)setDefaultLog
{
    [self redirectNSLogToDocumentFolder];
    
    
    
    //未捕获的Objective-C异常日志
    NSSetUncaughtExceptionHandler(&UncaughtExceptionHandler);
}

- (void)clearExpiredLog
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"]];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *logDirectory = [[paths objectAtIndex:0] stringByAppendingPathComponent:@"Log"];
    //获取日志目录下的所有文件
    NSArray* files = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:logDirectory error:nil];
    for (NSString *file in files) {//根据文件的创建日期
        NSDate *creatDate = [formatter dateFromString:file];
        if (creatDate) {
            NSTimeInterval oldTime = [creatDate timeIntervalSince1970];
            NSTimeInterval currTime = [[NSDate date] timeIntervalSince1970];
            
            NSTimeInterval second = currTime - oldTime;
            int day = (int)second / (24 * 3600);
            if (day >= 7) {//研究一下该清除机制！！！
                // 删除该文件
                [[NSFileManager defaultManager] removeItemAtPath:[NSString stringWithFormat:@"%@/%@", logDirectory,file] error:nil];
                
                NSLog(@"[%@]日志文件已被删除！",file);
            }
        }
    }
}
@end
