//
//  TcViewController.m
//  Topcoder
//
//  Created by Anuj Kumar on 11/07/12.
//  Copyright (c) 2012 anuj.bhambhani@gmail.com. All rights reserved.
//

#import "TcViewController.h"
#import "TcViewControllerDataDisplay.h"

@interface TcViewController ()

@end

@implementation TcViewController
@synthesize textField;
@synthesize secondviewData;
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
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

- (IBAction)passData:(id)sender {
    TcViewControllerDataDisplay *second=[[TcViewControllerDataDisplay alloc ]initWithNibName:nil bundle:nil];
    self.secondviewData = second;
    secondviewData.passedValue=textField.text;
    [self presentModalViewController:second animated:YES];
}
@end
