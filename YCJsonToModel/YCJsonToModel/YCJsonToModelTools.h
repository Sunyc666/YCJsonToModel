//
//  YCJsonToModelTools.h
//  YCJsonToModel
//
//  Created by yc on 2021/3/16.
//  Copyright © 2021 syc. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface YCJsonToModelTools : NSObject

/// 判断数据源是否合法，如果合法正常返回，反之提示
/// @param jsonData 数据源
+(NSDictionary *)getJsonDicWithJsonData:(NSString *)jsonData;

/// 获取当前系统时间
+(NSString *)getCurrentTimesStr;

/// 报错输出
/// @param desStr 错误原因
+(void)errorLogWithDes:(NSString *)desStr;

/// 依据旧字符串生成一个首字母大写的字符串
/// @param oldStr 旧字符串
+(NSString *)getFirstLetterCapitalizedStrWithOldStr:(NSString *)oldStr;

/// 生成下层model的类名
/// @param mainName 主级类名
/// @param subName 次级类名
+(NSString *)syntheticModelClassNameWithMainName:(NSString *)mainName
                                         subName:(NSString *)subName;


/// 依据文件名称和内容生成 model 文件
/// @param className className
/// @param fileContent fileContent
+(void)creatFileWithClassName:(NSString *)className
                  fileContent:(NSString *)fileContent;

/// 自动生成拼接了Model的类名称
/// @param oldStr oldStr
+(NSString *)appendModelStrWithOldStr:(NSString *)oldStr;
@end

NS_ASSUME_NONNULL_END
