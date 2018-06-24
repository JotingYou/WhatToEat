
//
//  YJTableViewController.m
//  WhatToEat
//
//  Created by 姚家庆 on 2017/8/1.
//  Copyright © 2017年 Joting. All rights reserved.
//

#import "YJTableViewController.h"
#import "YJGroups.h"
#import "YJEditTableViewController.h"
#import "YJFoods.h"
@interface YJTableViewController ()
@property (strong,nonatomic) YJGroups *groups;
@property (strong, nonatomic) UIBarButtonItem *playItem;
@property (strong,nonatomic) YJObject *element;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *addItem;
@end

@implementation YJTableViewController
-(YJObject *)element{
    if (!_element) {
        _element = self.groups.elements[self.row];
    }
    return _element;
}
-(YJGroups *)groups{
    if (!_groups) {
        _groups = [YJGroups read];
    }
    return _groups;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    if (self.element.isSelected) {
        self.playItem = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemStop target:self action:@selector(playItemClicked:)];
    }else{
        self.playItem = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemPlay target:self action:@selector(playItemClicked:)];
    }
    self.navigationItem.rightBarButtonItems = @[self.addItem,_playItem];
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.groups =  [self.groups init];

    self.element = self.groups.elements[self.row];
    [self.tableView reloadData];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)playItemClicked:(id)sender {
    if (self.element.isSelected) {
        self.element.selected = false;
    }else{
        self.element.selected = true;
    }
    [self.element write];
    [self.navigationController popViewControllerAnimated:YES];

}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    return self.element.name;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.element.names.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"foodCell" forIndexPath:indexPath];
    cell.textLabel.text = self.element.names[indexPath.row];
    return cell;
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
        NSMutableArray *mArray = [NSMutableArray arrayWithArray:self.element.names];
        [mArray removeObjectAtIndex:indexPath.row];
        self.element.names = mArray;
        [self.element write];
        [self.tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationLeft];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}



// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}



// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}



#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    YJEditTableViewController *vc = [segue destinationViewController];
    vc.type = 0;
    vc.element = self.element;
}


@end
