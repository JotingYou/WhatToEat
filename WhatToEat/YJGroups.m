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
-(instancetype)init{
    if (self = [super init]) {
        _groups = [[YJAwardManager shared] readGroups];
        if (_groups.count == 0) {
            _groups = @[[YJFoods fruit]];
        }
        
    }
    return self;
}
-(void)addGroupWith:(NSString *)name and:(NSString *)info{
    Group *g = [[YJAwardManager shared] insertGroup:name :info :true];
    
    NSMutableArray *ma = [NSMutableArray arrayWithArray:self.groups];
    [ma addObject:g];
    self.groups = ma;
    
    [[YJAwardManager shared] save];
}
-(void)group:(Group *)group addPersonWithName:(NSString *)name Info:(NSString *)info{
    [[YJAwardManager shared] insertPeople:name :info :group];
    [[YJAwardManager shared] save];
}
+(instancetype)shared{
    static YJGroups *g;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        g = [[self alloc] init];
    });
    return g;
}
-(void)deleteGroup:(Group *) group{
    for (People *p in group.members.allObjects) {
        [[YJAwardManager shared] deletePeople:p];
    }
    [[YJAwardManager shared] deleteGroup:group];
    
    NSMutableArray *ma = [NSMutableArray arrayWithArray:self.groups];
    [ma removeObject:group];
    self.groups = ma;
    
    [[YJAwardManager shared] save];
}
-(void)deletePerson:(People *)p{
    [[YJAwardManager shared] deletePeople:p];
    [[YJAwardManager shared] save];
}
@end
