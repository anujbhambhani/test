//
//  TcViewControllerDataDisplay.h
//  Topcoder
//
//  Created by Anuj Kumar on 11/07/12.
//  Copyright (c) 2012 anuj.bhambhani@gmail.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TcViewControllerDataDisplay : UIViewController{
    NSString *passedValue;
}
- (IBAction)back:(id)sender;
@property (weak, nonatomic) IBOutlet UILabel *label;
@property NSString *passedValue;
@end
