//
//  TcViewController.h
//  Topcoder
//
//  Created by Anuj Kumar on 11/07/12.
//  Copyright (c) 2012 anuj.bhambhani@gmail.com. All rights reserved.

#import <UIKit/UIKit.h>
#import "TcViewControllerDataDisplay.h"
@interface TcViewController : UIViewController<UITextFieldDelegate>{
    TcViewControllerDataDisplay *secondviewData;
}
- (IBAction)passData:(id)sender;
@property (weak, nonatomic) IBOutlet UITextField *textField;
@property (nonatomic,retain) TcViewControllerDataDisplay *secondviewData;
@end
