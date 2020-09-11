
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
#import "YJFoodCell.h"
@interface YJTableViewController ()
@property (weak,nonatomic) YJGroups *groups;
@property (strong, nonatomic) UIBarButtonItem *playItem;
@property (strong,nonatomic) Group *element;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *addItem;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *fileItem;
@end

@implementation YJTableViewController
-(Group *)element{
    if (!_element) {
        _element = self.groups.groups[self.row];
    }
    return _element;
}
-(YJGroups *)groups{
    if (!_groups) {
        _groups = [YJGroups shared];
    }
    return _groups;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    if (self.element.selected) {
        self.playItem = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemStop target:self action:@selector(playItemClicked:)];
    }else{
        self.playItem = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemPlay target:self action:@selector(playItemClicked:)];
    }
    self.navigationItem.rightBarButtonItems = @[self.addItem,self.fileItem,_playItem];
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.element = self.groups.groups[self.row];
    [self.tableView reloadData];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)playItemClicked:(id)sender {
    if (self.element.selected) {
        self.element.selected = false;
    }else{
        self.element.selected = true;
    }
    [self.groups save];
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
    return self.element.members.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    YJFoodCell *cell = [tableView dequeueReusableCellWithIdentifier:@"foodCell" forIndexPath:indexPath];
    NSArray *people = self.element.members.allObjects;
    People *p = people[indexPath.row];
    cell.nameLabel.text = p.name;
    cell.infoLabel.text = p.info;
    cell.telLabel.text = p.tel;
    return cell;
}

#pragma mark - table view delegate

// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}



// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        NSArray *people = self.element.members.allObjects;
        People *p = people[indexPath.row];
        [self.groups deletePerson:p];
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
    UIViewController *vc = [segue destinationViewController];
    if ([vc isKindOfClass:YJEditTableViewController.class]) {
        YJEditTableViewController *evc = (YJEditTableViewController *)vc;
        evc.type = 0;
        evc.element = self.element;
    }else if ([vc isKindOfClass:[YJImportController class]]){
        YJImportController *ic = (YJImportController *)vc;
        ic.group = self.element;
    }
    

}


@end
