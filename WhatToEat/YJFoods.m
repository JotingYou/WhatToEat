//
//  YJFoods.m
//  WhatToEat
//
//  Created by 姚家庆 on 2017/8/1.
//  Copyright © 2017年 明星科技. All rights reserved.
//

#import "YJFoods.h"
#define kFoodName @"kFoodName"
#define kImageName @"kImageName"
@implementation YJFoods
-(instancetype)init{
    if (self = [super init]) {
        [self read];
    }
    return self;
}
-(void)read{
    _names = [[NSUserDefaults standardUserDefaults]arrayForKey:kFoodName];
    _imageNames = [[NSUserDefaults standardUserDefaults]arrayForKey:kImageName];
}
-(void)write{
    [[NSUserDefaults standardUserDefaults]setObject:self.names forKey:kFoodName];
    [[NSUserDefaults standardUserDefaults]setObject:self.imageNames forKey:kImageName];
}
-(NSArray *)names{
    if (!_names) {
        _names = [NSArray array];
    }
    return _names;
}
-(NSArray *)imageNames{
    if (!_imageNames) {
        _imageNames = [NSArray array];
    }
    return _imageNames;
}
@end
