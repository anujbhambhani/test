//
//  RegexMatcher.h
//  ParsingDateFromTc
//
//  Created by Anuj Kumar on 13/07/12.
//  Copyright (c) 2012 anuj.bhambhani@gmail.com. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RegexMatcher : NSObject

@property NSMutableString* urlString;
@property NSMutableString* regx;


-(NSRange) matchRegex:(NSMutableString *)regxx;

@end
