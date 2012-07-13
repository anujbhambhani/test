//
//  TcViewController.m
//  Topcoder
//
//  Created by Anuj Kumar on 11/07/12.
//  Copyright (c) 2012 anuj.bhambhani@gmail.com. All rights reserved.
//

#import "TcViewController.h"
#import "PlistOperations.h"
#import "URLParser.h"
#import "RegexMatcher.h"

@interface TcViewController ()

@end

@implementation TcViewController

@synthesize viewStatusOutlet;
@synthesize passDataOutlet;
@synthesize backOutlet;
@synthesize viewOutlet;
@synthesize textField;
@synthesize plistOperations;
- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}


//to make a keyboard disappear when user presses enter key
- (BOOL)textFieldShouldReturn:(UITextField *)theTextField 
{
    [theTextField resignFirstResponder];
    return YES; 
} 


- (void)viewDidUnload
{
    [self setTextField:nil];
    [self setViewOutlet:nil];
    [self setBackOutlet:nil];
    [self setPassDataOutlet:nil];
    [self setViewStatusOutlet:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

- (IBAction)viewStatus:(id)sender {
    
    [viewOutlet setHidden:NO];
    [backOutlet setHidden:NO];
    UIImageView *imgView = [[UIImageView alloc]initWithFrame: CGRectMake(0, 0, viewOutlet.frame.size.width, viewOutlet.frame.size.height)];
    imgView.image = [UIImage imageNamed: @"topcoder.png"];
    [viewOutlet addSubview: imgView];
    [viewOutlet sendSubviewToBack: imgView];
    URLParser *urlParser =[[URLParser alloc]init];
    RegexMatcher *regexMatcher = [[RegexMatcher alloc]init];
    NSRange range;
    
    plistOperations=[[PlistOperations alloc]init];
    [plistOperations readPlist];
    
    for(id key in plistOperations.dictionary){
        NSLog(@"key=%@ value=%@", key, [plistOperations.dictionary objectForKey:key]);
    }   
    @try{
        NSString *data;
        NSDictionary *dict = [[NSDictionary alloc]initWithDictionary:plistOperations.dictionary];
        for(id key in dict){
            NSLog(@"key=%@ value=%@", key, [plistOperations.dictionary objectForKey:key]);
            currentHandle=key;
            NSMutableString *hit=[NSMutableString stringWithString:@"https://www.otinn.com/topcoder/al/comparer.php?user1=petr&user2="]; 
            [hit appendString:key];
            NSLog(@"Hitting url%@",hit);
            data = [urlParser parseUrl:hit];
            if(data==nil)
            {
                [viewOutlet setText:@"No Internet connection."];
                return;
            }
            
            data = [data lowercaseString];
            
            
            NSMutableString *regx=[NSMutableString stringWithString:@"title=\".?.?.?.?.?\">"];
            [regx appendString:key];
            [regexMatcher setUrlString:data];
            range = [regexMatcher matchRegex:regx];
            NSLog(@"%i %i",range.location,range.length);
            range.location = range.location+7;
            range.length = range.length-7- [key length] -2;
            
            NSString *result = [data substringWithRange:range];
            [plistOperations.dictionary setObject: result forKey: key];
        }
        [plistOperations writePlist];
    }
    @catch (NSException *e) {
        NSLog(@"raised exception=%@",e);
    }
    NSMutableString *result=[[NSMutableString alloc]init ];
    for(id key in plistOperations.dictionary){
        NSLog(@"key=%@ value=%@", key, [plistOperations.dictionary objectForKey:key]);
        [result appendString:key];
        [result appendString:@"=>"];
        [result appendString:[plistOperations.dictionary objectForKey:key]];
        [result appendString:@"\n"];
    }
    NSLog(@"%@",result);
    [viewOutlet setText:result];
    
}
- (IBAction)passData:(id)sender {
    URLParser *urlParser =[[URLParser alloc]init];
    RegexMatcher *regexMatcher = [[RegexMatcher alloc]init];
    NSRange range;
    [textField setPlaceholder:@""];
    handleNotFound=NO;
    handleToTrack=textField.text;
    textField.text=@"Adding to track list...";
    handleToTrack = [handleToTrack lowercaseString];
    [textField setEnabled:NO];
    [passDataOutlet setEnabled:NO];
    [backOutlet setEnabled:NO];
    [viewStatusOutlet setEnabled:NO];
    counter=0;
    plistOperations=[[PlistOperations alloc]init];
    [plistOperations readPlist];
    [plistOperations.dictionary setObject: @"1" forKey: handleToTrack];
    
    for(id key in plistOperations.dictionary){
        NSLog(@"key=%@ value=%@", key, [plistOperations.dictionary objectForKey:key]);
    }   
    noOfHandles = [plistOperations.dictionary count];
    @try{
        NSString *data;
        NSDictionary *dict = [[NSDictionary alloc]initWithDictionary:plistOperations.dictionary];
        for(id key in dict){
            NSLog(@"key=%@ value=%@", key, [plistOperations.dictionary objectForKey:key]);
            currentHandle=key;
            NSMutableString *hit=[NSMutableString stringWithString:@"https://www.otinn.com/topcoder/al/comparer.php?user1=petr&user2="]; 
            [hit appendString:key];
            NSLog(@"Hitting url%@",hit);
            data = [urlParser parseUrl:hit];
            if(data==nil)
            {
                [self.textField resignFirstResponder];
                [textField setEnabled:YES];
                [passDataOutlet setEnabled:YES];
                [backOutlet setEnabled:YES];
                [viewStatusOutlet setEnabled:YES];
                textField.text=@"";
                [textField setPlaceholder:@"No Internet connection."];
                return;
            }
            
            data = [data lowercaseString];
            
            
            NSMutableString *regx=[NSMutableString stringWithString:@"title=\".?.?.?.?.?\">"];
            [regx appendString:key];
            [regexMatcher setUrlString:data];
            range = [regexMatcher matchRegex:regx];
            if(range.length==0)
            {
                handleNotFound = YES;
                break;
            }
            NSLog(@"%i %i",range.location,range.length);
            range.location = range.location+7;
            range.length = range.length-7- [key length] -2;
            
            NSString *result = [data substringWithRange:range];
            [plistOperations.dictionary setObject: result forKey: key];
        }
        if(!handleNotFound)
        {
            [plistOperations writePlist];
            NSLog(@"writing data completed");
            
        }
        [self.textField resignFirstResponder];
        [textField setEnabled:YES];
        [passDataOutlet setEnabled:YES];
        [backOutlet setEnabled:YES];
        [viewStatusOutlet setEnabled:YES];
        textField.text=@"";
        if(handleNotFound)
            [textField setPlaceholder:@"Handle Not Found."];
        else
            [textField setPlaceholder:@"Handle added"];
        
        
    }
    @catch (NSException *e) {
        NSLog(@"raised exception=%@",e);
    }
    
    
}
- (IBAction)back:(id)sender {
    [viewOutlet setHidden:YES];
    [backOutlet setHidden:YES];
}
@end
