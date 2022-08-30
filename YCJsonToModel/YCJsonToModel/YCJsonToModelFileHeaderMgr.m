//
//  YCJsonToModelFileHeaderMgr.m
//  YCJsonToModel
//
//  Created by yc on 2021/3/16.
//  Copyright © 2021 syc. All rights reserved.
//  生成类文件头部注释内容

#import "YCJsonToModelFileHeaderMgr.h"

NSString *const annotationStr = @"//";
NSString *const newlineSymbolStr = @"\n";
NSString *const twoSpace = @"  ";

@implementation YCJsonToModelFileHeaderMgr

/// 根据类名生成类中文件顶部注释内容，实现类似于手动创建类文件的效果
/// @param className 类文件名称
+(NSString *)getFileHeaderAnnotationWithClassName:(NSString *)className{
    if (YCCreatorName.length < 0) {
        [YCJsonToModelTools errorLogWithDes:@"请输入创建者"];
        return nil;
    }
    if (YCCreatorName.length < 0) {
        [YCJsonToModelTools errorLogWithDes:@"请输入版权所属"];
        return nil;
    }
    
    //1.准备类文件头部注释的数据源
    NSString *productName;
    if (YCProjectName.length > 0) {
        productName = YCProjectName;
    }else{
        NSString *bundleID = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleIdentifier"];
        productName = [[bundleID componentsSeparatedByString:@"."] lastObject];
    }
    
    NSString *timeStr = [NSString stringWithFormat:@"Created by %@ on %@.",YCCreatorName,[YCJsonToModelTools getCurrentTimesStr]];
    
    NSString *currentYearStr = [[[YCJsonToModelTools getCurrentTimesStr] componentsSeparatedByString:@"/"] firstObject];
    NSString *copyRightStr = [NSString stringWithFormat:@"Copyright © %@ %@. All rights reserved.",currentYearStr,YCCopyrightName];
    
    NSArray *fileHeaderAnnotationArr = @[
        annotationStr,
        newlineSymbolStr,
        annotationStr,
        twoSpace,
        className,
        newlineSymbolStr,
        annotationStr,
        twoSpace,
        productName,
        newlineSymbolStr,
        annotationStr,
        newlineSymbolStr,
        annotationStr,
        twoSpace,
        timeStr,
        newlineSymbolStr,
        annotationStr,
        twoSpace,
        copyRightStr,
        newlineSymbolStr,
        annotationStr,
        newlineSymbolStr,
    ];
    NSString *fileHeaderAnnotationStr = @"";
    for (NSString *item in fileHeaderAnnotationArr) {
        fileHeaderAnnotationStr = [fileHeaderAnnotationStr stringByAppendingString:item];
    }
    return fileHeaderAnnotationStr;
}



@end
