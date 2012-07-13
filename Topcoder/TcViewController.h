//
//  TcViewController.h
//  Topcoder
//
//  Created by Anuj Kumar on 11/07/12.
//  Copyright (c) 2012 anuj.bhambhani@gmail.com. All rights reserved.

#import <UIKit/UIKit.h>
#import "PlistOperations.h"
NSMutableData* downloadData;
@interface TcViewController : UIViewController<UITextFieldDelegate>{
    NSString *listPath;
    NSMutableArray *array; 
    NSMutableString *currentHandle;
    int counter;
    int noOfHandles;
    bool handleNotFound;
    NSString *handleToTrack;
}
@property (weak, nonatomic) IBOutlet UIButton *viewStatusOutlet;
@property (weak, nonatomic) IBOutlet UIButton *passDataOutlet;
@property (weak, nonatomic) IBOutlet UIButton *backOutlet;
- (IBAction)back:(id)sender;
@property (weak, nonatomic) IBOutlet UITextView *viewOutlet;
- (IBAction)viewStatus:(id)sender;
- (IBAction)passData:(id)sender;
-(NSString*) dataFilePath;
-(void)readPlist;
-(void)writePlist;
@property (weak, nonatomic) IBOutlet UITextField *textField;
@property PlistOperations *plistOperations;
@end
