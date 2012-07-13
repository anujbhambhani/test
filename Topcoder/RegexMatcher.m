//
//  RegexMatcher.m
//  ParsingDateFromTc
//
//  Created by Anuj Kumar on 13/07/12.
//  Copyright (c) 2012 anuj.bhambhani@gmail.com. All rights reserved.
//

#import "RegexMatcher.h"

@implementation RegexMatcher

@synthesize urlString;
@synthesize regx;

-(NSRange) matchRegex:(NSMutableString *)regxx{
    regx=regxx;
    
    
    
    NSError  *error  = NULL;
    NSRegularExpression *regex1 = [NSRegularExpression 
                                   regularExpressionWithPattern:regx
                                   options:0
                                   error:&error];
    NSLog(@"%@",urlString);
    NSRange range1   = [regex1 rangeOfFirstMatchInString:urlString
                                                 options:0 
                                                   range:NSMakeRange(0, [urlString length])];

    return range1;
}
@end
