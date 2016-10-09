//
//  jsonTableViewController.m
//  jsonText
//
//  Created by  AndyLiou on 2016/5/23.
//  Copyright © 2016年 Andy. All rights reserved.
//

#import "jsonTableViewController.h"
#import "jsonTableViewCell.h"
#import "DetailViewController.h"
@interface jsonTableViewController ()
{
      jsonObject * tableviewSingleton;
      NSInteger test;
}
@property(nonatomic,strong)NSMutableArray * selectArray;

@end

@implementation jsonTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setTitle:_areaName];
    
   tableviewSingleton = [jsonObject shareData];
    switch (self.i) {
        case 0:
            self.selectArray = [tableviewSingleton gettaoyuanCodeWithIndex];
            break;
        case 1:
            self.selectArray = [tableviewSingleton getjhongliCodeWithIndex];
            break;
        case 2:
            self.selectArray = [tableviewSingleton getdasiCodeWithIndex];
            break;
        case 3:
            self.selectArray = [tableviewSingleton getyangmeiCodeWithIndex];
            break;
        case 4:
            self.selectArray = [tableviewSingleton getdayuanCodeWithIndex];
            break;
        case 5:
            self.selectArray = [tableviewSingleton getlujhuCodeWithIndex];
            break;
        case 6:
            self.selectArray = [tableviewSingleton getgueishanCodeWithIndex];
            break;
        case 7:
            self.selectArray = [tableviewSingleton getbadeCodeWithIndex];
            break;
        case 8:
            self.selectArray = [tableviewSingleton getlongtanCodeWithIndex];
            break;
        case 9:
            self.selectArray = [tableviewSingleton getpingjhenCodeWithIndex];
            break;
        case 10:
            self.selectArray = [tableviewSingleton getsinwuCodeWithIndex];
            break;
        case 11:
            self.selectArray = [tableviewSingleton getguanyinCodeWithIndex];
            break;
        case 12:
            self.selectArray = [tableviewSingleton getfusingCodeWithIndex];
            break;
        default:
            break;
    }

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

    return self.selectArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    jsonTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"jsonTableViewCell" forIndexPath:indexPath];
    test = [[self.selectArray objectAtIndex:indexPath.row]intValue ];
    cell.nameLabel.text =[tableviewSingleton getnameWithIndex:test];
    cell.addLabel.text = [@"地址:" stringByAppendingString:[tableviewSingleton getaddWithIndex:test]];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    DetailViewController * detailVC =[self.storyboard instantiateViewControllerWithIdentifier:@"DetailViewController"];
    test = [[self.selectArray objectAtIndex:indexPath.row]intValue ];

    detailVC.i = test;
    [self.navigationController pushViewController:detailVC animated:YES];
    
    
}

@end
