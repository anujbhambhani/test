//
//  URLParser.h
//  ParsingDateFromTc
//
//  Created by Anuj Kumar on 13/07/12.
//  Copyright (c) 2012 anuj.bhambhani@gmail.com. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface URLParser : NSObject

@property NSMutableString* urlToParse;

-(NSMutableString*) parseUrl:(NSMutableString*)url;

@end
