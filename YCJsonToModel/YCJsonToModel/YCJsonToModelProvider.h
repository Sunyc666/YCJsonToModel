//
//  YCJsonToModelProvider.h
//  YCJsonToModel
//
//  Created by yc on 2021/3/16.
//  Copyright © 2021 syc. All rights reserved.
//

#import <Foundation/Foundation.h>

#define YCModelFileMgr [YCJsonToModelProvider ycModelMgr]


NS_ASSUME_NONNULL_BEGIN

@interface YCJsonToModelProvider : NSObject

/// 生成model文件入口
/// @param className 类名
/// @param superClassName 父类名称：如果填写则继承，否则继承 NSObject
/// @param filePath 文件目标路径：需手动配置 model 文件上层目录路径
/// @param jsonData json数据源
/// @param multipleFiles 是否生成多个 model 文件
+(void)yc_jsonToModelWithClassName:(NSString *)className
                    superClassName:(NSString *)superClassName
                          filePath:(NSString *)filePath
                          jsonData:(NSString *)jsonData
                     multipleFiles:(BOOL)multipleFiles;


@end

NS_ASSUME_NONNULL_END
