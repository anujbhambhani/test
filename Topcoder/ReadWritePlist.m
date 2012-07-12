//
//  ReadWritePlist.m
//  Topcoder
//
//  Created by Anuj Kumar on 12/07/12.
//  Copyright (c) 2012 anuj.bhambhani@gmail.com. All rights reserved.
//

#import "ReadWritePlist.h"

@implementation ReadWritePlist



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
}
-(void)writePlist{
    [dictionary writeToFile:[self dataFilePath] atomically:YES];
}

@end
