//
//  TcViewControllerDataDisplay.m
//  Topcoder
//
//  Created by Anuj Kumar on 11/07/12.
//  Copyright (c) 2012 anuj.bhambhani@gmail.com. All rights reserved.
//

#import "TcViewControllerDataDisplay.h"
#import "TcViewController.h"

@interface TcViewControllerDataDisplay ()

@end

@implementation TcViewControllerDataDisplay
@synthesize label;
@synthesize passedValue;

-(IBAction)back:(id)sender{
    TcViewController *second=[[TcViewController alloc]initWithNibName:nil bundle:nil];
    [self presentModalViewController:second animated:YES];
}
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}


-(void)loadData: (NSString *)dataPath{
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:dataPath] cachePolicy:NSURLRequestReloadIgnoringCacheData timeoutInterval:10];
    [NSURLConnection connectionWithRequest:request delegate:self];
}
-(void) connection:(NSURLConnection*) connection didReceiveData:(NSData *)data{
    [downloadData appendData:data];
}

-(void) connection:(NSURLConnection*) connection didFailWithError:(NSError *)error{
    NSLog(@"Failed %@",[error description]);
}
-(void) connection:(NSURLConnection*) connection didReceiveResponse:(NSURLResponse *)response{
    downloadData = [NSMutableData data];
}

-(void) connectionDidFinishLoading:(NSURLConnection *)connection{
    NSString *dataString=[[NSString alloc]initWithData:downloadData encoding:NSUTF8StringEncoding];
    NSMutableString *string1 = [NSMutableString stringWithString: dataString];
    //adding regex
    NSMutableString *string  =string1;
    NSError  *error  = NULL;
    NSMutableString *regx=[NSMutableString stringWithString:@"title=\".?.?.?.?.?\">"];
    [regx appendString:passedValue];
    NSRegularExpression *regex = [NSRegularExpression 
                                  regularExpressionWithPattern:regx
                                  options:0
                                  error:&error];
    
    NSRange range   = [regex rangeOfFirstMatchInString:string
                                               options:0 
                                                 range:NSMakeRange(0, [string length])];
    
    NSLog(@"%i %i",range.location,range.length);
    range.location = range.location+7;
    range.length = range.length-7- [passedValue length] -2;
    NSMutableString *result = [string substringWithRange:range];
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *stringsPlistPath = [[paths objectAtIndex:0] stringByAppendingPathComponent:@"Strings.plist"];
    NSArray  * stringsArray = [NSArray arrayWithObjects:@"foo",@"bar",@"baz",nil];
    [stringsArray writeToFile:stringsPlistPath atomically:YES];
    label.text=result;
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    NSString* handle=passedValue;
    NSMutableString *hit=[NSMutableString stringWithString:@"https://www.otinn.com/topcoder/al/comparer.php?user1=petr&user2="];
    [hit appendString:handle];
    [self loadData:hit];
    // Do any additional setup after loading the view from its nib.
}

- (void)viewDidUnload
{
    [self setLabel:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
@end
