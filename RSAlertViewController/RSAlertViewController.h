//
// RSAlertViewController.h
//
// Copyright (c) Rushi Sangani.
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.

#import <UIKit/UIKit.h>

@interface RSAlertViewController : UIViewController

/* properties */

@property (nonatomic, strong) UIColor *titleColor;               // title color

@property (nonatomic, strong) UIColor *textColor;                // text color

@property (nonatomic, strong) UIColor *buttonsColor;             // buttons color

@property (nonatomic, assign) NSTextAlignment textAlignment;     // set text alignment for message, default is center

@property (nonatomic, assign) BOOL dismissOnTapOutside;          // dismiss alertview on outside touch, default is NO

/* singleton instance */

+(instancetype)sharedInstance;

/* global method to show alert */

-(instancetype)showAlertWithTitle:(NSString *)title message:(NSString *)message buttons:(NSArray *)buttonTitles fromViewController:(UIViewController *)viewController withActionHandler:(void(^)(NSUInteger buttonIndex))actionHandler;

@end
