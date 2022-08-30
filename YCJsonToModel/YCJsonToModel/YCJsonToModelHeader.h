//
//  YCJsonToModelHeader.h
//  YCJsonToModel
//
//  Created by yc on 2021/3/16.
//  Copyright © 2021 syc. All rights reserved.
//


#ifndef YCJsonToModelHeader_h
#define YCJsonToModelHeader_h
#import "YCJsonToModelFileHeaderMgr.h"

#import <MJExtension.h>
#import "YCJsonToModelTools.h"
#import "YCJsonToModelHFileMgr.h"
#import "YCJsonToModelMFileMgr.h"


#define YCProjectName @""       //工程名称（若bundleid符合“com.xx.xx”格式，可不填，并会以“.”拆分为数组并取末位元素）

/**
 以下信息请务必填写
 */
#define YCCreatorName @"syc"    //创建者
#define YCCopyrightName @"YC"   //版权所属
#define ModelFileOutputPath @"/Users/mac/Desktop/测试输出" //文件输出路径

#define YCHFileMgr [YCJsonToModelHFileMgr shareInstance]

#endif /* YCJsonToModelHeader_h */
