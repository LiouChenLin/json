//
//  AppDelegate.h
//  jsonText
//
//  Created by  AndyLiou on 2016/5/23.
//  Copyright © 2016年 Andy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ViewController.h"
#import "Reachability.h"
@interface AppDelegate : UIResponder <UIApplicationDelegate>
{
    Reachability *reachabilty;
}

@property (strong, nonatomic) UIWindow *window;


@end

