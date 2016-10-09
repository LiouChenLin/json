//
//  mapAnnViewController.m
//  jsonText
//
//  Created by  AndyLiou on 2016/6/2.
//  Copyright © 2016年 Andy. All rights reserved.
//

#import "mapAnnViewController.h"
#import "jsonObject.h"
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>
@interface mapAnnViewController ()<MKMapViewDelegate,CLLocationManagerDelegate>
{
    CLLocationManager * locationManager;
    jsonObject *  mapSingleton;
    BOOL isFirstLocationReceived;   
    NSInteger index;

}
@property (weak, nonatomic) IBOutlet MKMapView *mapView;
@end

@implementation mapAnnViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    mapSingleton = [jsonObject shareData];
    
    
    locationManager =[CLLocationManager new];
    [locationManager requestWhenInUseAuthorization];
    
    
    // prepare locationManager
    locationManager.desiredAccuracy =kCLLocationAccuracyBest; //定位等級
    locationManager.activityType=CLActivityTypeAutomotiveNavigation;  //自動判別移動
   
    locationManager.delegate=self; //可code可拉線
    [locationManager startUpdatingLocation];   //開始回報位置
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)typeSegment:(id)sender {
    
    NSInteger targetIndex=[sender selectedSegmentIndex];
    switch (targetIndex) {
        case 0:
            _mapView.mapType=MKMapTypeStandard;  //一般標準
            break;
        case 1:
            _mapView.mapType=MKMapTypeSatellite; //衛星
            break;
            
        case 2:
            _mapView.mapType=MKMapTypeHybrid; //混合
            break;
            
            
        default:
            break;
    }

}
#pragma mark - CLLocationManagerDelegate Methods
//開始接收  delegate //變數array locations  <CLLocation *> 宣告他的型別所以只能存CLLocation型別的物件
-(void) locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations
{
//    _mapView.showsUserLocation = YES;
    CLLocation * currentLocation = locations.lastObject;

    if(isFirstLocationReceived==false)
    {
        MKCoordinateRegion region =_mapView.region;
        region.center = currentLocation.coordinate;
        region.span.latitudeDelta=0.05;   //span定地地圖縮放大小 緯度   用數字控制縮放大小
        region.span.longitudeDelta=0.05;  //span定地地圖縮放大小 經度   用數字控制縮放大小
        [_mapView setRegion:region animated:true]; //讓region進入動畫 aniimated是否做動畫 這邊做動作
        
        isFirstLocationReceived =true;
        //Add Annotation 加入大頭針
        for (int i = 0; i<=[mapSingleton getTotal]; i++) {
            CLLocationCoordinate2D storeCoodinate = CLLocationCoordinate2DMake([[mapSingleton getpyWithIndex:i]floatValue], [[mapSingleton getpxWithIndex:i]floatValue]);
             MKPointAnnotation * annotation = [MKPointAnnotation new];
            
            annotation.title = [mapSingleton getnameWithIndex:i];
            annotation.subtitle = [mapSingleton getaddWithIndex:i];
            annotation.coordinate = storeCoodinate;
            [_mapView addAnnotation:annotation];
        }
        
    }
    
    
}


- (MKAnnotationView *) mapView:(MKMapView *)mapView viewForAnnotation:(id <MKAnnotation>) annotation
{
    
    if ([annotation isKindOfClass:[MKUserLocation class]])
        return nil;
    
    MKAnnotationView *annotationView = [[MKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:@"loc"];
    annotationView.tintColor = [UIColor blueColor];
    annotationView.canShowCallout = YES;
    
    UIButton * button = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
    [button addTarget:self action:@selector(buttonPressed:) forControlEvents:UIControlEventTouchUpInside];
    annotationView.rightCalloutAccessoryView = button;
    
    return annotationView;
    
}
-(void)mapView:(MKMapView *)mapView didSelectAnnotationView:(MKAnnotationView *)view
{
    MKPointAnnotation *point = view.annotation;

    
    index = [mapSingleton giveyouindex:point.title];
    

}
-(void)buttonPressed:(id)seder{
   NSLog(@"大頭針名：  %@",[mapSingleton getnameWithIndex:index]);
    UIAlertController * alert =[UIAlertController alertControllerWithTitle:[mapSingleton getnameWithIndex:index] message:[mapSingleton gettolDescribeWithIndex:index] preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction * navgation = [UIAlertAction actionWithTitle:@"導航" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        float px = [[mapSingleton getpxWithIndex:index]floatValue];
        float py = [[mapSingleton getpyWithIndex:index]floatValue];
        
        MKMapItem *currentLocation = [MKMapItem mapItemForCurrentLocation];
        MKPlacemark * local = [[MKPlacemark alloc]initWithCoordinate:CLLocationCoordinate2DMake(py,px) addressDictionary:nil];
        MKMapItem * localItem = [[MKMapItem alloc] initWithPlacemark:local];
        localItem.name = [mapSingleton getnameWithIndex:index];
        NSArray *array = [[NSArray alloc] initWithObjects:currentLocation, localItem, nil];
        
        NSDictionary *param = [NSDictionary dictionaryWithObject:MKLaunchOptionsDirectionsModeDriving forKey:MKLaunchOptionsDirectionsModeKey];
        
        [MKMapItem openMapsWithItems:array launchOptions:param];
    }];
    UIAlertAction * cancel =[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:nil];
    
    [alert addAction:cancel];
    [alert addAction:navgation];
    [self presentViewController:alert animated:true completion:nil];
    
}


@end
