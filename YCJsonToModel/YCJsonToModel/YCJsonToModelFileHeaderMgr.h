//
//  YCJsonToModelFileHeaderMgr.h
//  YCJsonToModel
//
//  Created by yc on 2021/3/16.
//  Copyright © 2021 syc. All rights reserved.
//  

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface YCJsonToModelFileHeaderMgr : NSObject

/// 根据类名生成类中文件顶部注释内容，实现类似于手动创建类文件的效果
/// @param className 类文件名称
+(NSString *)getFileHeaderAnnotationWithClassName:(NSString *)className;

@end

NS_ASSUME_NONNULL_END
