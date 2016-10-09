//
//  jsonObject.m
//  jsonText
//
//  Created by  AndyLiou on 2016/5/27.
//  Copyright © 2016年 Andy. All rights reserved.
//

#import "jsonObject.h"

@implementation jsonObject{
    NSMutableArray * name ;              //名字
    NSMutableArray * parkingInfo;        //停車資訊
    NSMutableArray * tel;                //電話
    NSMutableArray * add;                //地址
    NSMutableArray * openTime;           //開放時間
    NSMutableArray * tolDescribe;        //介紹細節
    NSMutableArray * remarks;            //額外備註
    NSMutableArray * travellingInfo;     //交通資訊
    NSMutableArray * zipCode;            //郵遞區號
    NSMutableArray * px;
    NSMutableArray * py;
    NSInteger test;
    NSMutableArray * taoyuanCode;       //桃園330
    NSMutableArray * jhongliCode;       //中壢328
    NSMutableArray * dasiCode;          //大溪335
    NSMutableArray * yangmeiCode;       //楊梅326
    NSMutableArray * dayuanCode;        //大園337
    NSMutableArray * lujhuCode;         //蘆竹338
    NSMutableArray * gueishanCode;      //龜山333
    NSMutableArray * badeCode;          //八德334
    NSMutableArray * longtanCode;       //龍潭325
    NSMutableArray * pingjhenCode;      //平鎮324
    NSMutableArray * sinwuCode;         //新屋327
    NSMutableArray * guanyinCode;       //觀音328
    NSMutableArray * fusingCode;        //復興336
    NSMutableArray * areaArray;
    NSString * telcontrolString;    //修改電話問題
    BOOL loadProgress;
}

static jsonObject * _viewSingletonManager;
+(instancetype) shareData
{
    if (_viewSingletonManager == nil) {
        _viewSingletonManager = [jsonObject new];
        [_viewSingletonManager loaDatas];
    }
    return _viewSingletonManager;
}
-(void)loaDatas{
    NSURL *url = [NSURL URLWithString:@"http://data.tycg.gov.tw/api/v1/rest/datastore/bd906b29-9006-40ed-8bd7-67597c2577fc?format=json"];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    NSData* data = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    name= [[NSMutableArray alloc]init];
    parkingInfo= [[NSMutableArray alloc]init];
    tel= [[NSMutableArray alloc]init];
    add= [[NSMutableArray alloc]init];
    openTime= [[NSMutableArray alloc]init];
    tolDescribe= [[NSMutableArray alloc]init];
    remarks= [[NSMutableArray alloc]init];
    travellingInfo= [[NSMutableArray alloc]init];
    zipCode = [[NSMutableArray alloc]init];
    px = [[NSMutableArray alloc]init];
    py = [[NSMutableArray alloc]init];
    
    taoyuanCode = [[NSMutableArray alloc]init];
    jhongliCode = [[NSMutableArray alloc]init];
    dasiCode = [[NSMutableArray alloc]init];
    yangmeiCode = [[NSMutableArray alloc]init];
    dayuanCode = [[NSMutableArray alloc]init];
    lujhuCode = [[NSMutableArray alloc]init];
    gueishanCode = [[NSMutableArray alloc]init];
    badeCode = [[NSMutableArray alloc]init];
    longtanCode = [[NSMutableArray alloc]init];
    pingjhenCode = [[NSMutableArray alloc]init];
    sinwuCode = [[NSMutableArray alloc]init];
    guanyinCode = [[NSMutableArray alloc]init];
    fusingCode = [[NSMutableArray alloc]init];
    areaArray = [[NSMutableArray alloc]init];
    
    NSDictionary* jsonDictionary = [[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil]objectForKey:@"result"];
    NSArray * resultArray = [jsonDictionary objectForKey:@"records"];

    for (NSDictionary * dic in resultArray)
    {
        NSString * nameString = [dic objectForKey:@"name"];
        NSString * parkingInfoString = [dic objectForKey:@"parkingInfo"];
        NSString * addString = [dic objectForKey:@"add"];
        NSString * pxString = [dic objectForKey:@"px"];
        NSString * pyString = [dic objectForKey:@"py"];
        NSString * telString;
        telcontrolString = [dic objectForKey:@"tel"];
      if ([telcontrolString hasPrefix:@"886"])
      {
        if ([telcontrolString hasPrefix:@"886-886-"])
            {
                              telString = [@"0" stringByAppendingString:[telcontrolString substringFromIndex:8]];
            }else if ([telcontrolString hasPrefix:@"886-"])
            {
                telString = [@"0" stringByAppendingString:[telcontrolString substringFromIndex:4]];

            }

       
      }else{
          telString = telcontrolString;
      }

        NSString * openTimeString = [dic objectForKey:@"openTime"];
        NSString * tolDescribeString = [dic objectForKey:@"tolDescribe"];
        NSString * remarksString = [dic objectForKey:@"remarks"];
        NSString * travellingInfoString = [dic objectForKey:@"travellingInfo"];
        NSString * zipCodeString =[dic objectForKey:@"zipCode"];
       
        if (nameString || parkingInfoString || addString || pxString || pxString || pyString || telString || openTimeString || tolDescribeString || remarksString ||  travellingInfoString || zipCodeString)
        {
            [px addObject:pxString];
            [py addObject:pyString];
            [name addObject:nameString];
            [parkingInfo addObject:parkingInfoString];
            [add addObject:addString];
          
            [tel addObject:telString];
            [openTime addObject:openTimeString];
            [tolDescribe addObject:tolDescribeString];
            [remarks addObject:remarksString];
            [travellingInfo addObject:travellingInfoString];
            [zipCode addObject:zipCodeString];
        }
        if([zipCodeString isEqualToString:@"330"])
        {
            test = [name indexOfObject:nameString];
            NSString * taoyuan = [[NSString alloc]initWithFormat:@"%li",test];
            [taoyuanCode addObject:taoyuan];
        }
        if([zipCodeString isEqualToString:@"320"])
        {
            test = [name indexOfObject:nameString];
            NSString * jhongli = [[NSString alloc]initWithFormat:@"%li",test];
            [jhongliCode addObject:jhongli];
        }
        if([zipCodeString isEqualToString:@"335"])
        {
            test = [name indexOfObject:nameString];
            NSString * dasi = [[NSString alloc]initWithFormat:@"%li",test];
            [dasiCode addObject:dasi];
        }
        if([zipCodeString isEqualToString:@"326"])
        {
            test = [name indexOfObject:nameString];
            NSString * yangmei = [[NSString alloc]initWithFormat:@"%li",test];
            [yangmeiCode addObject:yangmei];
        }
        if([zipCodeString isEqualToString:@"337"])
        {
            test = [name indexOfObject:nameString];
            NSString * dayuan = [[NSString alloc]initWithFormat:@"%li",test];
            [dayuanCode addObject:dayuan];
        }
        if([zipCodeString isEqualToString:@"338"])
        {
            test = [name indexOfObject:nameString];
            NSString * lujhu = [[NSString alloc]initWithFormat:@"%li",test];
            [lujhuCode addObject:lujhu];
        }
        if([zipCodeString isEqualToString:@"333"])
        {
            test = [name indexOfObject:nameString];
            NSString * gueishan = [[NSString alloc]initWithFormat:@"%li",test];
            [gueishanCode addObject:gueishan];
        }
        if([zipCodeString isEqualToString:@"334"])
        {
            test = [name indexOfObject:nameString];
            NSString * bade = [[NSString alloc]initWithFormat:@"%li",test];
            [badeCode addObject:bade];
        }
        if([zipCodeString isEqualToString:@"325"])
        {
            test = [name indexOfObject:nameString];
            NSString * longtan = [[NSString alloc]initWithFormat:@"%li",test];
            [longtanCode addObject:longtan];
        }
        if([zipCodeString isEqualToString:@"324"])
        {
            test = [name indexOfObject:nameString];
            NSString * pingjhen = [[NSString alloc]initWithFormat:@"%li",test];
            [pingjhenCode addObject:pingjhen];
        }
        if([zipCodeString isEqualToString:@"327"])
        {
            test = [name indexOfObject:nameString];
            NSString * sinwu = [[NSString alloc]initWithFormat:@"%li",test];
            [sinwuCode addObject:sinwu];
        }
        if([zipCodeString isEqualToString:@"328"])
        {
            test = [name indexOfObject:nameString];
            NSString * guanyin = [[NSString alloc]initWithFormat:@"%li",test];
            [guanyinCode addObject:guanyin];
        }
        if([zipCodeString isEqualToString:@"336"])
        {
            test = [name indexOfObject:nameString];
            NSString * fusing = [[NSString alloc]initWithFormat:@"%li",test];
            [fusingCode addObject:fusing];
        }

    }
    [areaArray addObject:taoyuanCode];
    [areaArray addObject:jhongliCode];
    [areaArray addObject:dasiCode];
    [areaArray addObject:yangmeiCode];
    [areaArray addObject:dayuanCode];
    [areaArray addObject:lujhuCode];
    [areaArray addObject:gueishanCode];
    [areaArray addObject:badeCode];
    [areaArray addObject:longtanCode];
    [areaArray addObject:pingjhenCode];
    [areaArray addObject:sinwuCode];
    [areaArray addObject:guanyinCode];
    [areaArray addObject:fusingCode];

    loadProgress =true;
}

-(NSInteger)getAreaCountWithIndex:(NSInteger)index
{
    
    if (index==0) {
        return [taoyuanCode count];
    }
    if (index==1) {
        return [jhongliCode count];
    }
    if (index==2) {
        return [dayuanCode count];
    }
    if (index==3) {
        return [yangmeiCode count];
    }
    if (index==4) {
        return [dayuanCode count];
    }
    if (index==5) {
        return [lujhuCode count];
    }
    if (index==6) {
        return [gueishanCode count];
    }
    if (index==7) {
        return [badeCode count];
    }
    if (index==8) {
        return [longtanCode count];
    }
    if (index==9) {
        return [pingjhenCode count];
    }
    if (index==10) {
        return [sinwuCode count];
    }
    if (index==11) {
        return [guanyinCode count];
    }
    if (index==12) {
        return [fusingCode count];
    }

    return 0;
}
-(BOOL)getLoadStatus
{
    return loadProgress;
}
-(NSInteger)getTotal
{
    return [name count];
}

-(NSMutableArray*)gettaoyuanCodeWithIndex
{
    return taoyuanCode;
}
-(NSMutableArray*)getjhongliCodeWithIndex
{
   
    return jhongliCode;
}
-(NSMutableArray*)getdasiCodeWithIndex
{
    return dasiCode;
}
-(NSMutableArray*)getyangmeiCodeWithIndex
{
    return yangmeiCode;
}
-(NSMutableArray*)getdayuanCodeWithIndex
{
    return dayuanCode;
}
-(NSMutableArray*)getlujhuCodeWithIndex
{
    return lujhuCode;
}
-(NSMutableArray*)getgueishanCodeWithIndex
{
    return gueishanCode;
}
-(NSMutableArray*)getbadeCodeWithIndex
{
  
    return badeCode;
}
-(NSMutableArray*)getlongtanCodeWithIndex
{
    return longtanCode;
}
-(NSMutableArray*)getpingjhenCodeWithIndex
{
    return pingjhenCode;
}
-(NSMutableArray*)getsinwuCodeWithIndex
{
    return sinwuCode;
}
-(NSMutableArray*)getguanyinCodeWithIndex
{
  
    return guanyinCode;
}
-(NSMutableArray*)getfusingCodeWithIndex
{
    return fusingCode;
}
-(NSString*)getlocationManagerWithIndex:(NSInteger)index
{
    if(index<0 || index >=self.locationManager.count)
    {
        return nil;
    }
    return self.locationManager[index];
}

-(NSString*)getnameWithIndex:(NSInteger)index
{
    if(index<0 || index >=name.count)
    {
        return nil;
    }
    return name[index];
}
-(NSString*)getparkingInfoWithIndex:(NSInteger)index
{
    if(index<0 || index >=parkingInfo.count)
    {
        return nil;
    }
    return parkingInfo[index];
}
-(NSString*)getaddWithIndex:(NSInteger)index
{
    if(index<0 || index >=add.count)
    {
        return nil;
    }
    return add[index];
}
-(NSString*)gettelWithIndex:(NSInteger)index
{
    if(index<0 || index >=tel.count)
    {
        return nil;
    }
    return tel[index];
}
-(NSString*)getopenTimeWithIndex:(NSInteger)index
{
    if(index<0 || index >=openTime.count)
    {
        return nil;
    }
    return openTime[index];
}
-(NSString*)gettolDescribeWithIndex:(NSInteger)index
{
    if(index<0 || index >=tolDescribe.count)
    {
        return nil;
    }
    return tolDescribe[index];
}
-(NSString*)gettravellingInfoWithIndex:(NSInteger)index
{
    if(index<0 || index >=travellingInfo.count)
    {
        return nil;
    }
    return travellingInfo[index];
}
-(NSString*)getremarksWithIndex:(NSInteger)index
{
    if(index<0 || index >=remarks.count)
    {
        return nil;
    }
    return remarks[index];
}
-(NSString*)getzipCodeWithIndex:(NSInteger)index
{
    if(index<0 || index >=zipCode.count)
    {
        return nil;
    }
    return zipCode[index];
}
-(NSString*)getpxWithIndex:(NSInteger)index
{
    if(index<0 || index >=px.count)
    {
        return nil;
    }
    return px[index];
}
-(NSString*)getpyWithIndex:(NSInteger)index
{
    if(index<0 || index >=py.count)
    {
        return nil;
    }
    return py[index];
}
-(NSInteger)giveyouindex:(NSString*)string
{    NSInteger index = [name indexOfObject:string];
    return index;
}
@end
