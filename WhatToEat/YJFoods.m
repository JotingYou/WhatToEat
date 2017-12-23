//
//  YJFoods.m
//  WhatToEat
//
//  Created by 姚家庆 on 2017/8/1.
//  Copyright © 2017年 明星科技. All rights reserved.
//

#import "YJFoods.h"
@implementation YJFoods
-(instancetype)init{
    if (self = [super initWithName:@"food"]) {
        if (!self.names.count) {
            self.names = @[@"🍕",@"🍫",@"🍚",@"🍜",@"🍔",@"🍣",@"🍲"];
            self.selected = true;
            [self write];
        }
    }
    return self;
}
+(instancetype)read{
    return [[self alloc]init];
}

@end
