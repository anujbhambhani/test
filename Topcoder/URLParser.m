//
//  URLParser.m
//  ParsingDateFromTc
//
//  Created by Anuj Kumar on 13/07/12.
//  Copyright (c) 2012 anuj.bhambhani@gmail.com. All rights reserved.
//

#import "URLParser.h"

@implementation URLParser

@synthesize  urlToParse;
-(NSMutableString*) parseUrl:(NSMutableString*)url{
    urlToParse=url;
    NSError *error = nil;
    NSData *data = [[NSString stringWithContentsOfURL:[NSURL URLWithString:urlToParse] encoding:NSUTF8StringEncoding error:&error] dataUsingEncoding:NSUTF8StringEncoding];
    
    
    if(error) { // some error occured
        NSLog(@"check connection");
        return nil;
    }
    else {
        NSLog(@"success");
        NSMutableString* dataString = [[NSMutableString alloc] initWithData:data
                                                  encoding:NSUTF8StringEncoding];
        return dataString;
    }
    
}
@end
