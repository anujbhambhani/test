//
//  TcAppDelegate.m
//  Topcoder
//
//  Created by Anuj Kumar on 11/07/12.
//  Copyright (c) 2012 anuj.bhambhani@gmail.com. All rights reserved.
//

#import "TcAppDelegate.h"

#import "TcViewController.h"

@implementation TcAppDelegate

@synthesize window = _window;
@synthesize viewController = _viewController;



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



- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    self.viewController = [[TcViewController alloc] initWithNibName:@"TcViewController" bundle:nil];
    self.window.rootViewController = self.viewController;
    [self.window makeKeyAndVisible];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
