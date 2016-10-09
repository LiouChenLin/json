//
//  zipCodeTableViewController.m
//  jsonText
//
//  Created by  AndyLiou on 2016/5/29.
//  Copyright © 2016年 Andy. All rights reserved.
//

#import "zipCodeTableViewController.h"
#import "zipCodeTableViewCell.h"
#import "jsonTableViewController.h"
@interface zipCodeTableViewController ()
{
    jsonObject * zipCodeSingleton;
}
@property(nonatomic,strong)NSMutableArray * areaArray;
@end

@implementation zipCodeTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    zipCodeSingleton = [jsonObject shareData];
    self.areaArray = [[NSMutableArray alloc]initWithObjects:@"桃園區",@"中壢區",@"大溪區",@"楊梅區",@"大園區",@"蘆竹區"
                      ,@"龜山區",@"八德區",@"龍潭區",@"平鎮區",@"新屋區",@"觀音區",@"復興區", nil];
  
    [[UINavigationBar appearance] setTitleTextAttributes:
     @{NSForegroundColorAttributeName: [UIColor whiteColor],
    NSFontAttributeName: [UIFont fontWithName:@"Helvetica" size: 22.0f]}];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.areaArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    zipCodeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"zipCodeTableViewCell" forIndexPath:indexPath];
    cell.areaNameLabel.text = [self.areaArray objectAtIndex:[indexPath row]];
    
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    jsonTableViewController * tableVC =[self.storyboard instantiateViewControllerWithIdentifier:@"jsonTableViewController"];
    tableVC.i = indexPath.row;
    tableVC.areaName = self.areaArray[indexPath.row];
    [self.navigationController pushViewController:tableVC animated:YES];
    
    
}

@end
