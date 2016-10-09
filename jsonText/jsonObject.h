//
//  jsonObject.h
//  jsonText
//
//  Created by  AndyLiou on 2016/5/27.
//  Copyright © 2016年 Andy. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface jsonObject : NSObject
@property (nonatomic,strong)NSMutableArray * locationManager;
+(instancetype)shareData;
-(BOOL)getLoadStatus;
-(NSInteger)getTotal;
-(NSString*)getlocationManagerWithIndex:(NSInteger)index;
-(NSString*) getnameWithIndex:(NSInteger)index;
-(NSString*) getparkingInfoWithIndex:(NSInteger)index;
-(NSString*) getaddWithIndex:(NSInteger)index;
-(NSString*) gettelWithIndex:(NSInteger)index;
-(NSString*) getopenTimeWithIndex:(NSInteger)index;
-(NSString*) gettolDescribeWithIndex:(NSInteger)index;
-(NSString*) getremarksWithIndex:(NSInteger)index;
-(NSString*) gettravellingInfoWithIndex:(NSInteger)index;
-(NSString*) getzipCodeWithIndex:(NSInteger)index;
-(NSString*)getpxWithIndex:(NSInteger)index;
-(NSString*)getpyWithIndex:(NSInteger)index;
-(NSInteger)giveyouindex:(NSString*)string;

-(NSMutableArray*)gettaoyuanCodeWithIndex;
-(NSMutableArray*)getfusingCodeWithIndex;
-(NSMutableArray*)getguanyinCodeWithIndex;
-(NSMutableArray*)getsinwuCodeWithIndex;
-(NSMutableArray*)getpingjhenCodeWithIndex;
-(NSMutableArray*)getlongtanCodeWithIndex;
-(NSMutableArray*)getbadeCodeWithIndex;
-(NSMutableArray*)getgueishanCodeWithIndex;
-(NSMutableArray*)getlujhuCodeWithIndex;
-(NSMutableArray*)getdayuanCodeWithIndex;
-(NSMutableArray*)getyangmeiCodeWithIndex;
-(NSMutableArray*)getdasiCodeWithIndex;
-(NSMutableArray*)getjhongliCodeWithIndex;



@end
