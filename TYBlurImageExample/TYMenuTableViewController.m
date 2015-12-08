//
//  TYMenuTableViewController.m
//  TYBlurImageExample
//
//  Created by 田奕焰 on 15/12/8.
//  Copyright © 2015年 luckytianyiyan. All rights reserved.
//

#import "TYMenuTableViewController.h"
#import "TYPlayAnimationViewController.h"

static NSString* const kTableViewCellIdentifier = @"tableViewCellIdentifier";

@interface TYMenuTableViewController ()

@end

@implementation TYMenuTableViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:kTableViewCellIdentifier];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kTableViewCellIdentifier forIndexPath:indexPath];
    
    cell.textLabel.text = @"Play Animation";
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    TYPlayAnimationViewController *playAnimationViewController = [[TYPlayAnimationViewController alloc] init];
    [self.navigationController pushViewController:playAnimationViewController animated:NO];
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
