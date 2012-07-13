//
//  TcSRMTimeDifference.m
//  Topcoder
//
//  Created by Anuj Kumar on 13/07/12.
//  Copyright (c) 2012 anuj.bhambhani@gmail.com. All rights reserved.
//

#import "TcSRMTimeDifference.h"
#import "URLParser.h"
#import "RegexMatcher.h"
@implementation TcSRMTimeDifference

-(NSDateComponents*) getTimeDifference{
    NSString* result2;
    
    // insert code here...
    //NSLog(@"Hello, World!");
    URLParser *urlParser=[[URLParser alloc]init];
    NSMutableString* url=[NSMutableString stringWithString:@"http://community.topcoder.com/tc"];
    NSMutableString *data=[urlParser parseUrl:url];
    if(data==nil)
    {
        NSLog(@"Check Internet Connection");
        return nil;
    }
    else{
        NSLog(@"data=%u",[data length]);
        //NSLog(@"hi"); 
        RegexMatcher *regexMatcher=[[RegexMatcher alloc]init];
        [regexMatcher setUrlString:data];
        NSMutableString*  regex=[NSMutableString stringWithString:@"Next SRM"];
        NSRange range1=[regexMatcher matchRegex:regex];
        if(range1.length==0){
            NSLog(@"Next SRM Data not found");
            return nil;
        }
        else{
            range1.length+=150;
            range1.location-=150;
            NSString *result1 = [data substringWithRange:range1];
            NSLog(@"%@",result1);
            [regexMatcher setUrlString:[NSMutableString stringWithString:result1]];
            regex=[NSMutableString stringWithString:@"<div class=\"prizes\">.*</div>"];
            range1 = [regexMatcher matchRegex:regex];
            if(range1.length==0){
                NSLog(@"Next SRM Date Not Found");
            }
            else{
                range1.location+=20;
                range1.length=range1.length-20-10;
                result2 = [result1 substringWithRange:range1];
                NSLog(@"SRM Date=%@=",result2);
            }
        }
    }
    NSDate *now = [NSDate date];
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy MMM dd, HH:mm"];
    NSMutableString *ddate = [NSMutableString stringWithString:@"2012 "];
    [ddate appendString:result2];
    
    [formatter setTimeZone:[NSTimeZone timeZoneWithName:@"America/New_York"]];
    
    NSLog(@"now=%@",[formatter stringFromDate:now]); 
    NSDate *date=[[NSDate alloc]init];
    date = [formatter dateFromString:ddate];
    NSLog(@"%@",[formatter stringFromDate:date]);
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar] ;
    NSDateComponents *components=[[NSDateComponents alloc]init];
    components = [calendar components:NSYearCalendarUnit|NSMonthCalendarUnit|NSDayCalendarUnit|NSHourCalendarUnit | NSMinuteCalendarUnit
                             fromDate:now
                               toDate:date
                              options:0];
    NSInteger hour = [components hour];
    NSLog(@"%d",hour);
    return components;
}
@end
