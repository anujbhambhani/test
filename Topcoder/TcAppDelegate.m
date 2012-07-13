//
//  TcAppDelegate.m
//  Topcoder
//
//  Created by Anuj Kumar on 11/07/12.
//  Copyright (c) 2012 anuj.bhambhani@gmail.com. All rights reserved.
//

#import "TcAppDelegate.h"

#import "TcViewController.h"
#import "TcSRMTimeDifference.h"

@implementation TcAppDelegate

@synthesize window = _window;
@synthesize viewController = _viewController;

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
    TcSRMTimeDifference *tcSRMTimeDifference=[[TcSRMTimeDifference alloc]init];
    NSDateComponents *components = [[tcSRMTimeDifference getTimeDifference] copy];
    NSLog(@"hour=%i\n",components.hour);
    NSDate *now=[[NSDate alloc]init];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy MMM dd, HH:mm"];
    [formatter setTimeZone:[NSTimeZone timeZoneWithName:[[NSTimeZone localTimeZone] name]]];
    NSLog(@"anow=%@",[formatter stringFromDate:now]); 
    
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    
    NSCalendar *calender = [NSCalendar autoupdatingCurrentCalendar];
    NSDateComponents *dateComponents = [calender components:(NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit) fromDate:now];
    NSDateComponents *timeComponents = [calender components:(NSHourCalendarUnit| NSMinuteCalendarUnit| NSSecondCalendarUnit) fromDate:now];
    NSDateComponents * temp = [[NSDateComponents alloc]init];
    [temp setYear:[dateComponents year]+[components year]];
    [temp setMonth:[dateComponents month]+[components month]];
    [temp setDay:[dateComponents day]+[components day]];
    [temp setHour:[timeComponents hour]+[components hour]];
    [temp setMinute:[timeComponents minute]+[components minute]];
    //for testing 
//    [temp setYear:[dateComponents year]];
//    [temp setMonth:[dateComponents month]];
//    [temp setDay:[dateComponents day]];
//    [temp setHour:[timeComponents hour]];
//    [temp setMinute:[timeComponents minute]];
//    [temp setSecond:[timeComponents second]+[components hour]];
    NSDate *fireTime = [calender dateFromComponents:temp];
    
    //set up the notifier
    UILocalNotification *localNotification = [[UILocalNotification alloc]init];
    localNotification.fireDate = fireTime;
    localNotification.alertBody = @"SRM is starting please login to arena";
    localNotification.alertAction= @"View";
    NSDictionary *dict = [NSDictionary dictionaryWithObject:@"obj"  forKey:@"key"];
    localNotification.userInfo = dict;
    [[UIApplication sharedApplication] scheduleLocalNotification:localNotification];
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
