//
//  YJObject.m
//  WhatToEat
//
//  Created by Zhangguo Huang on 2017/12/23.
//  Copyright © 2017年 明星科技. All rights reserved.
//

#import "YJObject.h"

@implementation YJObject
-(instancetype)initWithName:(NSString *)name{
    if (self = [super init]) {
        NSString *kName = [NSString stringWithFormat:@"k%@Name",name];
        NSString *kImage = [NSString stringWithFormat:@"k%@Image",name];
        NSString *kSelected = [NSString stringWithFormat:@"k%@Selected",name];
        _names = [[NSUserDefaults standardUserDefaults]arrayForKey:kName];
        _imageNames = [[NSUserDefaults standardUserDefaults]arrayForKey:kImage];
        _selected = [[NSUserDefaults standardUserDefaults]boolForKey:kSelected];
        _name = name;
    }
    return self;
}
+(instancetype)readWithName:(NSString *)name{

    return [[self alloc]initWithName:name];
}
-(void)write{
    NSString *kName = [NSString stringWithFormat:@"k%@Name",_name];
    NSString *kImage = [NSString stringWithFormat:@"k%@Image",_name];
    NSString *kSelected = [NSString stringWithFormat:@"k%@Selected",_name];
    [[NSUserDefaults standardUserDefaults]setObject:self.names forKey:kName];
    [[NSUserDefaults standardUserDefaults]setObject:self.imageNames forKey:kImage];
    [[NSUserDefaults standardUserDefaults]setBool:self.isSelected forKey:kSelected];
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
