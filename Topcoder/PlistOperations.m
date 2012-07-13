//
//  PlistOperations.m
//  Topcoder
//
//  Created by Anuj Kumar on 13/07/12.
//  Copyright (c) 2012 anuj.bhambhani@gmail.com. All rights reserved.
//

#import "PlistOperations.h"

@implementation PlistOperations

@synthesize dictionary;

-(id)init
{
    self = [super init];
    if(self)
    {
        self.dictionary = [[NSMutableDictionary alloc] init];
    }
    return self;
    
}

-(NSString*) dataFilePath{
    NSArray* path=NSSearchPathForDirectoriesInDomains(NSDocumentDirectory , NSUserDomainMask, YES);
    NSString* documentDirectory = [path objectAtIndex:0];
    return [documentDirectory stringByAppendingPathComponent:@"handles.plist"];
}
-(void)readPlist{
    NSString *filePath= [self dataFilePath];
    if([[NSFileManager defaultManager]fileExistsAtPath:filePath])
    {
        dictionary=[[NSMutableDictionary alloc]initWithContentsOfFile:filePath];
        NSLog(@"%@",dictionary);
        NSLog(@"%@",filePath);
        
        for(id key in dictionary)
            NSLog(@"key=%@ value=%@", key, [dictionary objectForKey:key]);
    }
    else {
        dictionary=[[NSMutableDictionary alloc]init];
    }
}
-(void)writePlist{
    [dictionary writeToFile:[self dataFilePath] atomically:YES];
}


@end
