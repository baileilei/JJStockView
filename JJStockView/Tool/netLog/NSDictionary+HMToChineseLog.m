//
//  NSDictionary+HMToChineseLog.m
//  MaintainApp
//
//  Created by smart-wift on 2019/6/24.
//  Copyright © 2019 huawei. All rights reserved.
//

#import "NSDictionary+HMToChineseLog.h"

@implementation NSDictionary (HMToChineseLog)

#ifdef DEBUG

- (NSString*)description {
       return [self QC_descriptionWithLevel:1];
}

- (NSString*)descriptionWithLocale:(nullable)locale {
       return [self QC_descriptionWithLevel:1];
}
- (NSString*)descriptionWithLocale:(nullable)locale indent:(NSUInteger)level {
       return [self QC_descriptionWithLevel:(int)level];
}

/**
  * 非字典时，会引发崩溃
  */
- (NSString*)QC_getUTF8String {
       if ([self isKindOfClass:[NSDictionary class]] ==NO) {
               return @"";
            }
       NSError *error = nil;
       NSData *data = [NSJSONSerialization dataWithJSONObject:self options:NSJSONWritingPrettyPrinted error:&error];
       if (error) {
               return @"";
            }
       NSString *str = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
       return str;
}


- (NSString*)QC_descriptionWithLevel:(int)level {
       NSString *subSpace = [self QC_getSpaceWithLevel:level];
       NSString *space = [self QC_getSpaceWithLevel:level -1];
       NSMutableString *retString = [[NSMutableString alloc]init];
       // 1、添加 {
        [retString appendString:[NSString stringWithFormat:@"{"]];
       // 2、添加 key : value;
        [self enumerateKeysAndObjectsUsingBlock:^(id _Nonnull key, id _Nonnull obj, BOOL * _Nonnull stop) {
               if ([obj isKindOfClass:[NSString class]]) {
                       NSString *value = (NSString*)obj;
                        value = [value stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
                       NSString *subString = [NSString stringWithFormat:@"\n%@\"%@\" : \"%@\",", subSpace, key, value];
                        [retString appendString:subString];
                    }else if ([obj isKindOfClass:[NSDictionary class]]) {
                           NSDictionary *dic = (NSDictionary*)obj;
                           NSString *str = [dic QC_descriptionWithLevel:level +1];
                            str = [NSString stringWithFormat:@"\n%@\"%@\" : %@,", subSpace, key, str];
                            [retString appendString:str];
                        }else if ([obj isKindOfClass:[NSArray class]]) {
                               NSArray *arr = (NSArray*)obj;
                               NSString *str = [arr descriptionWithLocale:nil indent:level +1];
                                str = [NSString stringWithFormat:@"\n%@\"%@\" : %@,", subSpace, key, str];
                                [retString appendString:str];
                            }else {
                                   NSString *subString = [NSString stringWithFormat:@"\n%@\"%@\" : %@,", subSpace, key, obj];
                                    [retString appendString:subString];
                                }
            }];
       if ([retString hasSuffix:@","]) {
                [retString deleteCharactersInRange:NSMakeRange(retString.length-1,1)];
            }
       // 3、添加 }
        [retString appendString:[NSString stringWithFormat:@"\n%@}", space]];
       return retString;
}


- (NSString*)QC_getSpaceWithLevel:(int)level {
       NSMutableString *mustr = [[NSMutableString alloc]init];
       for (int i=0; i<level; i++) {
                [mustr appendString:@"\t"];
            }
       return mustr;
}

#endif

@end
