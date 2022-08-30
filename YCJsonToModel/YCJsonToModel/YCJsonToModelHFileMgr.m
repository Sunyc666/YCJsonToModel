//
//  YCJsonToModelHFileMgr.m
//  YCJsonToModel
//
//  Created by yc on 2021/3/16.
//  Copyright © 2021 syc. All rights reserved.
//  用以生成.h文件代码

#import "YCJsonToModelHFileMgr.h"

//属性拼接用字符串
NSString *const copyTypeStr   = @"@property (nonatomic, copy)   ";
NSString *const assignTypeStr = @"@property (nonatomic, assign) ";
NSString *const strongTypeStr = @"@property (nonatomic, strong) ";

//数据类型拼接用字符串
NSString *const typeStr       = @"NSString *";
NSString *const typeInteger   = @"NSInteger ";
NSString *const typeArr       = @"NSArray *";

@interface YCJsonToModelHFileMgr()

/// 用以将.h文件中所有字符串拼接在一起
@property(nonatomic, copy)NSString *classFileContentStr;

/// 将所有由jsonDic传入的数据依据生成的model名称存入字典
@property(nonatomic, strong)NSMutableDictionary *classFileContentDic;
@end

@implementation YCJsonToModelHFileMgr


+(YCJsonToModelHFileMgr*)shareInstance{
    static YCJsonToModelHFileMgr * instance = nil;
    static dispatch_once_t predicate;
    dispatch_once(&predicate, ^{
        instance = [[[self class] alloc] init];
    });
    return instance;
}


/// 自动生成 .h 文件代码
/// @param jsonDic 数据源
/// @param className 文件名称
/// @param superClassName 父类名称 
-(NSDictionary *)autoCodeHFileWithJsonDic:(NSDictionary *)jsonDic
                                className:(NSString *)className
                           superClassName:(NSString *)superClassName{
    
    //2.拆分数据源并重组
    self.classFileContentDic = [NSMutableDictionary dictionary];
    self.classFileContentStr = @"";
    
    //3.判断数据源是否合法
    NSArray *keyArray = [jsonDic allKeys];
    if (keyArray.count==0){
        [YCJsonToModelTools errorLogWithDes:@"数据源不合法：键值对数量为0"];
        return @{};
    }
    //4.符合需求进入生成阶段
    [self yc_generateModelWihtDic:jsonDic
                        className:className
                   superClassName:superClassName];
    
    return @{
        @"allContent"          : self.classFileContentStr,
        @"respectivelyContent" : self.classFileContentDic
    };
}


/// 具体生成代码方法
/// @param jsonDic 数据源
/// @param className 文件名称
/// @param superClassName 父类名称
-(NSString *)yc_generateModelWihtDic:(NSDictionary *)jsonDic
                           className:(NSString *)className
                      superClassName:(NSString *)superClassName{
    //1.判断是否填充类名
    if (className.length == 0 || className == nil) {
        [YCJsonToModelTools errorLogWithDes:@"请输入初始Model名称"];
        return @"";
    }
    
    //1.1判断类名是否以Model结尾，如果包含将Model移动至末尾
    className = [YCJsonToModelTools appendModelStrWithOldStr:className];
    
    
    //2.判断父类名称是否填充
    if (superClassName.length == 0 || superClassName == nil) {
        superClassName = @"NSObject";
    }
    
    //3.判断数据源是否合法
    if ([jsonDic isKindOfClass:[NSDictionary class]] == NO) {
        [YCJsonToModelTools errorLogWithDes:@"数据源不合法：键值对数量为0"];
        return @"";
    }
    //4.判断数据源是否合法
    NSArray *keyArray = [jsonDic allKeys];
    if (keyArray.count==0){
        [YCJsonToModelTools errorLogWithDes:@"数据源不合法：键值对数量为0"];
        return @"";
    }
    
    //5.递归拼接
    NSString *fileStr=[NSString stringWithFormat:@"@interface %@ : %@ \n\n",className,superClassName];
    for(int i=0; i<keyArray.count; i++)
    {
        NSString *key = [keyArray objectAtIndex:i];
        id value = jsonDic[key];
        if([value isKindOfClass:[NSString class]])
        {
            fileStr = [NSString stringWithFormat:@"%@%@%@%@;\n",fileStr,copyTypeStr,typeStr,key];
        }
        else if([value isKindOfClass:[NSNumber class]])
        {
            fileStr = [NSString stringWithFormat:@"%@%@%@%@;\n",fileStr,assignTypeStr,typeInteger,key];
        }
        else if([value isKindOfClass:[NSArray class]])
        {
            fileStr = [NSString stringWithFormat:@"%@%@%@%@;\n",fileStr,strongTypeStr,typeArr,key];
            //判断是否为字典数组
            id subvalue = [value lastObject];
            if ([subvalue isKindOfClass:[NSDictionary class]]) {
                
                NSString *subName = [YCJsonToModelTools syntheticModelClassNameWithMainName:className
                                                                                    subName:key];
                [self yc_generateModelWihtDic:subvalue
                                    className:subName
                               superClassName:superClassName];
            }
        }else if([value isKindOfClass:[NSDictionary class]])
        {
            NSString *subName = [YCJsonToModelTools syntheticModelClassNameWithMainName:className
                                                                                subName:key];
            subName = [YCJsonToModelTools appendModelStrWithOldStr:subName];
            fileStr = [NSString stringWithFormat:@"%@%@%@ *%@;\n",fileStr,strongTypeStr,subName,key];
            
            [self yc_generateModelWihtDic:value
                                className:subName
                           superClassName:superClassName];
            
        }else if ([value isKindOfClass:NSClassFromString(@"__NSCFBoolean")])
        {
        }else
        {
            
            fileStr = [NSString stringWithFormat:@"%@%@%@ %@;\n",fileStr,strongTypeStr,typeStr,key];
        }
    }
    fileStr = [fileStr stringByAppendingString:@"\n@end\n\n"];
    
    [self.classFileContentDic setValue:fileStr forKey:className];
    self.classFileContentStr = [self.classFileContentStr stringByAppendingString:fileStr];
    return fileStr;
}


/// 将 .h 的内容打包到新版本文件的盒子里
/// @param hFileContent .h 文件内容
+(NSString *)packingInFormat:(NSString *)hFileContent superClassName:(NSString *)superClassName{
    NSString *packingStr = @"#import <Foundation/Foundation.h>\n\nNS_ASSUME_NONNULL_BEGIN\n\nYC_PACKINGREPLACENS_ASSUME_NONNULL_END";
    
    packingStr = [packingStr stringByReplacingOccurrencesOfString:@"YC_PACKINGREPLACE" withString:hFileContent];
    
    if (superClassName) {
        packingStr = [packingStr stringByReplacingOccurrencesOfString:@"<Foundation/Foundation.h>" withString:[NSString stringWithFormat:@"\"%@.h\"",superClassName]];
    }
    
    return packingStr;
}


@end
