//
//  YCJsonToModelMFileMgr.m
//  YCJsonToModel
//
//  Created by yc on 2021/3/16.
//  Copyright © 2021 syc. All rights reserved.
//  用以生成.m文件代码

#import "YCJsonToModelMFileMgr.h"


@implementation YCJsonToModelMFileMgr

/// 自动生成 .m 文件代码
/// @param className 文件名称
/// @param combinationModelNameArr 组合类名称
+(NSString *)autoCodeMFileWithClassName:(NSString *)className
                combinationModelNameArr:(nullable NSArray * )combinationModelNameArr{
    
    if (combinationModelNameArr) {
        NSString *mFileContentStr = [NSString stringWithFormat:@"#import \"%@.h\"\n",className];
        for (NSString *combinationModelName in combinationModelNameArr) {
            NSString *mFileContent = @"\n@implementation YC_REPLACECLASSNAME\n@end";
            
            mFileContent = [mFileContent stringByReplacingOccurrencesOfString:@"YC_REPLACECLASSNAME" withString:combinationModelName];
            
            mFileContentStr = [mFileContentStr stringByAppendingString:mFileContent];
            mFileContentStr = [mFileContentStr stringByAppendingString:@"\n"];
        }
        return mFileContentStr;
    }else{
        NSString *mFileContent = @"#import \"YC_REPLACECLASSNAME.h\"\n\n@implementation YC_REPLACECLASSNAME\n\n@end";
        
        mFileContent = [mFileContent stringByReplacingOccurrencesOfString:@"YC_REPLACECLASSNAME" withString:className];
        
        return mFileContent;
    }
    return nil;
}



@end
