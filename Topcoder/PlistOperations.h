//
//  PlistOperations.h
//  Topcoder
//
//  Created by Anuj Kumar on 13/07/12.
//  Copyright (c) 2012 anuj.bhambhani@gmail.com. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PlistOperations : NSObject

@property (retain) NSMutableDictionary* dictionary;
-(void)readPlist;
-(void)writePlist;
-(NSString*) dataFilePath;
-(id)init;
@end
