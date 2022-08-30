//
//  YCJsonToModelMFileMgr.h
//  YCJsonToModel
//
//  Created by yc on 2021/3/16.
//  Copyright © 2021 syc. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface YCJsonToModelMFileMgr : NSObject

/// 自动生成 .m 文件代码
/// @param className 文件名称
/// @param combinationModelNameArr 组合类名称
+(NSString *)autoCodeMFileWithClassName:(NSString *)className
                combinationModelNameArr:(nullable NSArray * )combinationModelNameArr;

@end

NS_ASSUME_NONNULL_END
