//
//  YJGroupTableViewController.m
//  WhatToEat
//
//  Created by Zhangguo Huang on 2017/12/23.
//  Copyright © 2017年 明星科技. All rights reserved.
//

#import "YJGroupTableViewController.h"
#import "YJEditTableViewController.h"
#import "YJTableViewController.h"
#import "YJGroups.h"
@interface YJGroupTableViewController ()
@property (strong,nonatomic) YJGroups *groups;
@end

@implementation YJGroupTableViewController
-(YJGroups *)groups{
    if (!_groups) {
        _groups = [YJGroups read];
    }
    return _groups;
}
- (void)viewDidLoad {
    [super viewDidLoad];

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.groups =  [self.groups init];
    [self.navigationController.navigationBar setBackgroundImage:[self imageWithColor:[UIColor colorWithWhite:0 alpha:1]] forBarMetrics:UIBarMetricsDefault];
    [self.tableView reloadData];

}
- (UIImage *)imageWithColor:(UIColor *)color {
    CGRect rect = CGRectMake(0, 0, 1, 1);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    [color setFill];
    CGContextFillRect(context, rect);
    UIImage *imgae = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return imgae;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.groups.names.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"groupCell" forIndexPath:indexPath];
    
    cell.textLabel.text = self.groups.names[indexPath.row];
    YJObject *element = self.groups.elements[indexPath.row];
    if (element.isSelected) {
        cell.detailTextLabel.text = NSLocalizedString(@"Selected", nil);
    }else{
        cell.detailTextLabel.text = nil;
    }
    
    return cell;    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [self performSegueWithIdentifier:@"toDetailSegue" sender:[NSNumber numberWithInteger:indexPath.row]];
}

// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}



// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        NSMutableArray *arrayM = [NSMutableArray arrayWithArray:self.groups.names];
        [arrayM removeObjectAtIndex:indexPath.row];
        self.groups.names = arrayM;
        arrayM = [NSMutableArray arrayWithArray:self.groups.elements];
        [arrayM removeObjectAtIndex:indexPath.row];
        self.groups.elements = arrayM ;
        [self.groups write];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
        
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}


/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/


// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}



#pragma mark - Navigation


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    UIViewController *destinationVC = [segue destinationViewController];
    if ([destinationVC isKindOfClass:YJEditTableViewController.class]) {
        YJEditTableViewController *vc = [segue destinationViewController];
        vc.type = 1;
    }else if ([destinationVC isKindOfClass:[YJTableViewController class]]){
        YJTableViewController *vc = [segue destinationViewController];
        NSNumber *number = sender;
        vc.row = number.integerValue;
    }

}


@end
