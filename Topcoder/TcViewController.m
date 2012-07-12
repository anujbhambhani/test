//
//  TcViewController.m
//  Topcoder
//
//  Created by Anuj Kumar on 11/07/12.
//  Copyright (c) 2012 anuj.bhambhani@gmail.com. All rights reserved.
//

#import "TcViewController.h"

@interface TcViewController ()

@end

@implementation TcViewController
@synthesize backOutlet;
@synthesize viewOutlet;
@synthesize textField;
@synthesize secondviewData;
- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
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
}
-(void)writePlist{
    [dictionary writeToFile:[self dataFilePath] atomically:YES];
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
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
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
    @synchronized(self){
        counter++;
        NSString *dataString=[[NSString alloc]initWithData:downloadData encoding:NSUTF8StringEncoding];
        NSMutableString *string1 = [NSMutableString stringWithString: dataString];
        //adding regex
        NSMutableString *string  =string1;
        NSError  *error  = NULL;
        NSMutableString *regx1=[NSMutableString stringWithString:@"Petr vs "];
        NSRegularExpression *regex1 = [NSRegularExpression 
                                       regularExpressionWithPattern:regx1
                                       options:0
                                       error:&error];
        NSRange range1   = [regex1 rangeOfFirstMatchInString:string
                                                     options:0 
                                                       range:NSMakeRange(0, [string length])];
        range1.length+=20;
        range1.location+=8;
        NSLog(@"%i %i",range1.location,range1.length);
        
        NSString *result1 = [string substringWithRange:range1];
        NSLog(@"result1=%@",result1);
        NSRange range2 = [result1 rangeOfString:@"-"];
        range2.length=range2.location-1;
        range2.location=0;
        result1 = [result1 substringWithRange:range2];
        NSLog(@"result1=%@}}",result1);
        
        
        
        
        
        
        NSMutableString *regx=[NSMutableString stringWithString:@"title=\".?.?.?.?.?\">"];
        [regx appendString:result1];
        
        NSRegularExpression *regex = [NSRegularExpression 
                                      regularExpressionWithPattern:regx
                                      options:0
                                      error:&error];
        NSRange range   = [regex rangeOfFirstMatchInString:string
                                                   options:0 
                                                     range:NSMakeRange(0, [string length])];
        
        
        NSLog(@"%i %i",range.location,range.length);
        range.location = range.location+7;
        range.length = range.length-7- [result1 length] -2;
        
        NSMutableString *result = [string substringWithRange:range];
        [dictionary setObject: result forKey: result1];
        if(counter==noOfHandles)
        {
            [self writePlist];
            NSLog(@"writing data completed");
            [self.textField resignFirstResponder];
        }
    }
}

- (IBAction)viewStatus:(id)sender {
    [self readPlist];
    NSMutableString *result=[[NSMutableString alloc]init ];
    
    for(id key in dictionary){
        NSLog(@"key=%@ value=%@", key, [dictionary objectForKey:key]);
        [result appendString:key];
        [result appendString:@"=>"];
        [result appendString:[dictionary objectForKey:key]];
        [result appendString:@"\n"];
    }
    NSLog(@"%@",result);
    [viewOutlet setHidden:NO];
    [viewOutlet setText:result];
    
    
    UIImageView *imgView = [[UIImageView alloc]initWithFrame: CGRectMake(0, 0, viewOutlet.frame.size.width, viewOutlet.frame.size.height)];
    imgView.image = [UIImage imageNamed: @"topcoder.png"];
    [viewOutlet addSubview: imgView];
    [viewOutlet sendSubviewToBack: imgView];

    
    [backOutlet setHidden:NO];
}
- (IBAction)passData:(id)sender {
    //[self writePlist];
    counter=0;
    [self readPlist];
    [dictionary setObject: @"1" forKey: textField.text];
    for(id key in dictionary){
        NSLog(@"key=%@ value=%@", key, [dictionary objectForKey:key]);
    }   
    noOfHandles = [dictionary count];
    @try{
        for(id key in dictionary){
            NSLog(@"key=%@ value=%@", key, [dictionary objectForKey:key]);
            currentHandle=key;
            NSMutableString *hit=[NSMutableString stringWithString:@"https://www.otinn.com/topcoder/al/comparer.php?user1=petr&user2="];
            [hit appendString:key];
            NSLog(@"Hitting url%@",hit);
            [self loadData:hit];
        }
    }
    @catch (NSException *e) {
        NSLog(@"anuj exception=%@",e);
    }
    [self writePlist];
    [self readPlist];
}
- (IBAction)back:(id)sender {
    [viewOutlet setHidden:YES];
    [backOutlet setHidden:YES];
}
@end
