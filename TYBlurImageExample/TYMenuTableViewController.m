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

@property (nonatomic, strong) NSArray *titles;
@property (nonatomic, strong) NSDictionary *viewControllersMap;

@end

@implementation TYMenuTableViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:kTableViewCellIdentifier];
    
    _titles = @[@"Blur Image", @"Play Blur Animation"];
    
    _viewControllersMap = @{@"Blur Image": @"TYViewController",
                            @"Play Blur Animation": @"TYPlayAnimationViewController"
                            };
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _titles.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kTableViewCellIdentifier forIndexPath:indexPath];
    
    cell.textLabel.text = _titles[indexPath.row];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    Class viewControllerClass = NSClassFromString(_viewControllersMap[_titles[indexPath.row]]);
    [self.navigationController pushViewController:[[viewControllerClass alloc] init] animated:NO];
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
