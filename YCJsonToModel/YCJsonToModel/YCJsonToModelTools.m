//
//  YCJsonToModelTools.m
//  YCJsonToModel
//
//  Created by yc on 2021/3/16.
//  Copyright © 2021 syc. All rights reserved.
//

#import "YCJsonToModelTools.h"


@implementation YCJsonToModelTools

/// 判断数据源是否合法，如果合法正常返回，反之提示
/// @param jsonData 数据源
+(NSDictionary *)getJsonDicWithJsonData:(NSString *)jsonData{
    //1.首选判断jsonData不能为空
    BOOL jsonDataIsEmpty = NO;//默认数据源不为空
    if ([jsonData isEqual:@"NULL"] || [jsonData isKindOfClass:[NSNull class]] || [jsonData isEqual:[NSNull null]] || [jsonData isEqual:NULL] || [[jsonData class] isSubclassOfClass:[NSNull class]] || jsonData == nil || jsonData == NULL || [jsonData isKindOfClass:[NSNull class]] || [[jsonData stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] length]==0 || [jsonData isEqualToString:@"<null>"] || [jsonData isEqualToString:@"(null)"]) {
        jsonDataIsEmpty = YES;
        [YCJsonToModelTools errorLogWithDes:@"json数据源不能为空"];
        return nil;
    }
    
    //2.判断传入数据是否为json
    NSDictionary *jsonDic = [jsonData mj_JSONObject];
    if(jsonDic==nil){
        //2.1去除数据源中所有空格
        NSString *nonSpaceStr=[YCJsonToModelTools removeAllSpaceInJsonData:jsonData];
        jsonDic= [nonSpaceStr mj_JSONObject];
        //2.2去除数据源中所有空格后依然为空
        if(jsonDic==nil){
            [YCJsonToModelTools errorLogWithDes:@"json数据源格式不合法"];
            return nil;
        }
    }
    
    //3.满足了数据源本身是json的要求，将转为NSDictionary的数据返回
    return jsonDic;
}

/// 获取当前系统时间
+(NSString *)getCurrentTimesStr{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"YYYY/MM/dd"];
    NSDate *datenow = [NSDate date];
    NSString *currentTimeString = [formatter stringFromDate:datenow];
    return currentTimeString;
}


/// 移除字符串中所有空格
/// @param jsonData jsonData数据源
+(NSString *)removeAllSpaceInJsonData:(NSString *)jsonData{
    NSArray * words = [jsonData componentsSeparatedByCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    NSString * nospacestring = [words componentsJoinedByString:@""];
    return nospacestring;
}


/// 报错输出
/// @param desStr 错误原因
+(void)errorLogWithDes:(NSString *)desStr{
    NSLog(@"%@", [NSString stringWithFormat:@"YCJsonToModel Error：<%@>",desStr]);
}

/// 依据旧字符串生成一个首字母大写的字符串
/// @param oldStr 旧字符串
+(NSString *)getFirstLetterCapitalizedStrWithOldStr:(NSString *)oldStr{
    NSString *resultString = @"";
    if (oldStr.length > 0) {
        resultString = [oldStr stringByReplacingCharactersInRange:NSMakeRange(0,1) withString:[[oldStr substringToIndex:1] capitalizedString]];
    }
    return resultString;
}

/// 生成下层model的类名
/// @param mainName 主级类名
/// @param subName 次级类名
+ (NSString *)syntheticModelClassNameWithMainName:(NSString *)mainName
                                          subName:(NSString *)subName{
    NSString *newClassName = @"";
    
    newClassName = [NSString stringWithFormat:@"%@%@",mainName,[YCJsonToModelTools getFirstLetterCapitalizedStrWithOldStr:subName]];
    
    return newClassName;
}


/// 依据文件名称和内容生成 model 文件
/// @param className className
/// @param fileContent fileContent
+(void)creatFileWithClassName:(NSString *)className
                  fileContent:(NSString *)fileContent{
    NSString *filePath = [ModelFileOutputPath stringByAppendingPathComponent:className];
    [fileContent writeToFile:filePath atomically:YES encoding:NSUTF8StringEncoding error:nil];
}

/// 自动生成拼接了Model的类名称
/// @param oldStr oldStr
+(NSString *)appendModelStrWithOldStr:(NSString *)oldStr{
    if ([oldStr rangeOfString:@"Model"].location == NSNotFound) {
        oldStr = [oldStr stringByAppendingString:@"Model"];
    }else{
        oldStr = [oldStr stringByReplacingOccurrencesOfString:@"Model" withString:@""];
        oldStr = [oldStr stringByAppendingString:@"Model"];
    }
    return oldStr;
}
@end
