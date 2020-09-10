//
//  YJFoods.m
//  WhatToEat
//
//  Created by 姚家庆 on 2017/8/1.
//  Copyright © 2017年 明星科技. All rights reserved.
//

#import "YJFoods.h"
#import <WhatToEat-Swift.h>
@implementation YJFoods
+(Group *)fruit{
    Group * g = [[YJAwardManager shared]insertGroup:@"fruit" :@"example" :true ];
    [[YJAwardManager shared] insertPeople:@"🍕" :@"" :g ];
    [[YJAwardManager shared] insertPeople:@"🍫" :@"" :g ];
    [[YJAwardManager shared] insertPeople:@"🍚" :@"" :g ];
    [[YJAwardManager shared] insertPeople:@"🍜" :@"" :g ];
    [[YJAwardManager shared] insertPeople:@"🍔" :@"" :g ];
    [[YJAwardManager shared] insertPeople:@"🍣" :@"" :g ];
    [[YJAwardManager shared] insertPeople:@"🍲" :@"" :g ];
    return g;
}

@end
