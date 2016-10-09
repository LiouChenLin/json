//
//  DetailViewController.m
//  jsonText
//
//  Created by  AndyLiou on 2016/5/29.
//  Copyright © 2016年 Andy. All rights reserved.
//

#import "DetailViewController.h"
#import "jsonObject.h"
#import <QuartzCore/QuartzCore.h>
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>

@interface DetailViewController ()<MKMapViewDelegate,CLLocationManagerDelegate>
{
    jsonObject * detailSingleton;
    NSString * textViewString;
}
@property (weak, nonatomic) IBOutlet UITextView *detailTextView;

@end

@implementation DetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    detailSingleton = [jsonObject shareData];

    [self.detailTextView setEditable:NO];
    
    textViewString =[[[[[[[[[[[[[[[
    [[@"電話： " stringByAppendingString:[detailSingleton gettelWithIndex:self.i]]stringByAppendingString:@"\n" ]
     stringByAppendingString:@"\n"]
    stringByAppendingString:@"開放時間：" ]stringByAppendingString:[detailSingleton getopenTimeWithIndex:self.i]]stringByAppendingString:@"\n"]
    stringByAppendingString:@"\n"]stringByAppendingString:@"地址："]
    stringByAppendingString:[detailSingleton getaddWithIndex:self.i]]stringByAppendingString:@"\n"]stringByAppendingString:@"\n"]stringByAppendingString:@"交通資訊"]stringByAppendingString:[detailSingleton gettravellingInfoWithIndex:self.i]]
                                   stringByAppendingString:@"\n"]stringByAppendingString:@"\n"]stringByAppendingString:@"備註："]stringByAppendingString:[detailSingleton getremarksWithIndex:self.i]];
    

     self.navigationItem.title =[detailSingleton getnameWithIndex:self.i];
}
-(void)viewDidLayoutSubviews
{
    self.detailTextView.text = textViewString;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
- (IBAction)navigationBtnPressed:(id)sender
{
    float px = [[detailSingleton getpxWithIndex:self.i]floatValue];
    float py = [[detailSingleton getpyWithIndex:self.i]floatValue];
    
    MKMapItem *currentLocation = [MKMapItem mapItemForCurrentLocation];
    MKPlacemark * local = [[MKPlacemark alloc]initWithCoordinate:CLLocationCoordinate2DMake(py,px) addressDictionary:nil];
    MKMapItem * localItem = [[MKMapItem alloc] initWithPlacemark:local];
    localItem.name = [detailSingleton getnameWithIndex:self.i];
    NSArray *array = [[NSArray alloc] initWithObjects:currentLocation, localItem, nil];
    
    NSDictionary *param = [NSDictionary dictionaryWithObject:MKLaunchOptionsDirectionsModeDriving forKey:MKLaunchOptionsDirectionsModeKey];
    
    [MKMapItem openMapsWithItems:array launchOptions:param];

}
- (IBAction)tolDescribeBtnPressed:(id)sender {
    NSString * title = [[detailSingleton getnameWithIndex:self.i]stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    
    NSString * detail = [[@"簡介：" stringByAppendingString:[detailSingleton gettolDescribeWithIndex:self.i]]stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    NSString * detail2 = [self removeSpaceAndNewline:detail];

    UIAlertController * alertcontroller=[UIAlertController alertControllerWithTitle:title message:detail2 preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction*understand=[UIAlertAction actionWithTitle:@"返回" style:UIAlertActionStyleDefault handler:nil];
    [alertcontroller addAction:understand];
    
    
    [self presentViewController:alertcontroller animated:YES completion:nil];

}
- (NSString *)removeSpaceAndNewline:(NSString *)str
{
    NSString *temp = [str stringByReplacingOccurrencesOfString:@" " withString:@""];
    temp = [temp stringByReplacingOccurrencesOfString:@"\n" withString:@""];
    return temp;
}
- (IBAction)callNumberBtnPressed:(id)sender {
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[@"tel://" stringByAppendingString:[detailSingleton gettelWithIndex:self.i]]]];
}

@end
