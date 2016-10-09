//
//  ViewController.m
//  jsonText
//
//  Created by  AndyLiou on 2016/5/23.
//  Copyright © 2016年 Andy. All rights reserved.
//

#import "ViewController.h"
#import "jsonObject.h"
#import "Reachability.h"
#import "zipCodeTableViewController.h"
#import "mapAnnViewController.h"

@interface ViewController ()
{
    jsonObject * zipCodeSingleton;
    Reachability * openData;
    NetworkStatus status;
}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(networkStatusChanged:) name:kReachabilityChangedNotification object:nil];
    //利用網站檢測 可以放自己的json檢測
    openData = [Reachability reachabilityWithHostName:@"www.apple.com"];
    [openData startNotifier]; //回報狀態改變


}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)networkStatusChanged:(NSNotification*)notify
{
   status = openData.currentReachabilityStatus;
    
    if(status == NotReachable)
    {
        NSLog(@"Not Reachable!");
        UIAlertController * alertcontroller=[UIAlertController alertControllerWithTitle:@"無網路連線" message:@"請確認網路狀態!"preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction*understand=[UIAlertAction actionWithTitle:@"我知道了" style:UIAlertActionStyleDefault handler:nil];
        [alertcontroller addAction:understand];
        
        
        [self presentViewController:alertcontroller animated:YES completion:nil];
    }
    else
    {
        NSLog(@"Reachable with %ld",status);
        zipCodeSingleton = [jsonObject shareData];
    }
}
- (IBAction)goToTableViewBtnPressed:(id)sender {
    
    if([zipCodeSingleton getLoadStatus]==false){
        NSLog(@"Not Reachable!");
        UIAlertController * alertcontroller=[UIAlertController alertControllerWithTitle:@"無網路連線" message:@"請確認網路狀態!"preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction*understand=[UIAlertAction actionWithTitle:@"我知道了" style:UIAlertActionStyleDefault handler:nil];
        [alertcontroller addAction:understand];
        
        
        [self presentViewController:alertcontroller animated:YES completion:nil];
        
    }
}
-(IBAction)exit:(UIStoryboardSegue*)sender{
}


- (IBAction)btnDidTap:(id)sender {
    if(status == NotReachable)
    {
        NSLog(@"Not Reachable!");
        UIAlertController * alertcontroller=[UIAlertController alertControllerWithTitle:@"無網路連線" message:@"請確認網路狀態!"preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction*understand=[UIAlertAction actionWithTitle:@"我知道了" style:UIAlertActionStyleDefault handler:nil];
        [alertcontroller addAction:understand];
        
        
        [self presentViewController:alertcontroller animated:YES completion:nil];
    }else{

    
    mapAnnViewController * mapAnnVC = [self.storyboard instantiateViewControllerWithIdentifier:@"mapAnnVC"];
    
    [self showViewController:mapAnnVC sender:nil];
    
    }
    
}

@end
