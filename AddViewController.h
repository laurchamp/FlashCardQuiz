//
//  AddViewController.h
//  Lab5
//
//  Created by Lauren Champeau on 3/30/17.
//  Copyright © 2017 Lauren Champeau. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef  void(^CompletionHandler)(NSString *question, NSString *answer);

@interface AddViewController : UIViewController <UITextFieldDelegate, UITextViewDelegate>

@property (copy, nonatomic) CompletionHandler completionHandler;

@end
