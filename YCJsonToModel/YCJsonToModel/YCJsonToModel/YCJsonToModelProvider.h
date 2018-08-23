//
//  YCJsonToModelProvider.h
//  YCJsonToModelFile
//
//  Created by sunyanchao on 2018/8/8.
//  Copyright © 2018年 pbph. All rights reserved.
//

#import <Foundation/Foundation.h>
#define YCModelFileMgr [YCJsonToModelProvider ycModelMgr]

@interface YCJsonToModelProvider : NSObject

+(YCJsonToModelProvider*)ycModelMgr;

/**
 生成model文件入口
 
 @param className 类名
 @param filePath 文件目标路径：需手动配置model文件上层目录路径
 @param jsonData 数据源
 @param mjSupport 是否支持 MJExtension
 */
-(void)yc_jsonTomodelWithClassName:(NSString *)className filePath:(NSString *)filePath jsonData:(NSString *)jsonData mjSupport:(BOOL)mjSupport;
@end
