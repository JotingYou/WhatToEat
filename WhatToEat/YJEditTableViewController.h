//
//  YJEditTableViewController.h
//  WhatToEat
//
//  Created by 姚家庆 on 2017/8/1.
//  Copyright © 2017年 Joting. All rights reserved.
//

#import <UIKit/UIKit.h>
@class YJObject;
@interface YJEditTableViewController : UITableViewController
@property (assign,nonatomic) NSUInteger type;
@property (strong,nonatomic) YJObject *element;
@end
