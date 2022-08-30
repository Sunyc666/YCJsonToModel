//
//  YCJsonToModelHFileMgr.h
//  YCJsonToModel
//
//  Created by yc on 2021/3/16.
//  Copyright © 2021 syc. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface YCJsonToModelHFileMgr : NSObject

+(YCJsonToModelHFileMgr*)shareInstance;

/// 自动生成 .h 文件代码
/// @param jsonDic 数据源
/// @param className 文件名称
/// @param superClassName 父类名称
-(NSDictionary *)autoCodeHFileWithJsonDic:(NSDictionary *)jsonDic
                             className:(NSString *)className
                       superClassName:(NSString *)superClassName;

/// 将 .h 的内容打包到新版本文件的盒子里
/// @param hFileContent .h 文件内容
+(NSString *)packingInFormat:(NSString *)hFileContent
              superClassName:(NSString *)superClassName;

@end

NS_ASSUME_NONNULL_END

