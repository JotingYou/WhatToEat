//
//  YJGroups.m
//  WhatToEat
//
//  Created by Zhangguo Huang on 2017/12/23.
//  Copyright © 2017年 明星科技. All rights reserved.
//

#import "YJGroups.h"
#import "YJFoods.h"
@implementation YJGroups
-(instancetype)initWithName:(NSString *)name{
    if (self = [super initWithName:name]) {        
        if (!self.names.count) {
            self.names = @[@"food"];
            _elements = @[[YJFoods read]];
        }else{
            NSMutableArray *arrayM = [NSMutableArray array];
            for (NSString *name in self.names) {
                YJObject *model = [YJObject readWithName:name];
                [arrayM addObject:model];
            }
            _elements = [NSArray arrayWithArray:arrayM];
        }
        
    }
    return self;
}
-(instancetype)init{
    return [self initWithName:@"groups"];;
}
+(instancetype)read{
    return [[self alloc]initWithName:@"groups"];
}
@end
