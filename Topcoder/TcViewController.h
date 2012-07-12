//
//  TcViewController.h
//  Topcoder
//
//  Created by Anuj Kumar on 11/07/12.
//  Copyright (c) 2012 anuj.bhambhani@gmail.com. All rights reserved.

#import <UIKit/UIKit.h>
#import "TcViewControllerDataDisplay.h"
NSMutableData* downloadData;
@interface TcViewController : UIViewController<UITextFieldDelegate>{
    TcViewControllerDataDisplay *secondviewData;
    NSString *listPath;
    NSMutableArray *array; 
    NSMutableString *currentHandle;
    NSMutableDictionary *dictionary;
    int counter;
    int noOfHandles;
}
@property (weak, nonatomic) IBOutlet UIButton *backOutlet;
- (IBAction)back:(id)sender;
@property (weak, nonatomic) IBOutlet UITextView *viewOutlet;
- (IBAction)viewStatus:(id)sender;
- (IBAction)passData:(id)sender;
-(NSString*) dataFilePath;
-(void)readPlist;
-(void)writePlist;
@property (weak, nonatomic) IBOutlet UITextField *textField;
@property (nonatomic,retain) TcViewControllerDataDisplay *secondviewData;
@end
