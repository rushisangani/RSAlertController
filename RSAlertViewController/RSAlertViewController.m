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


#define kDefaultBackgroundColor [UIColor colorWithRed:(239/255.f) green:(239/255.f) blue:(241/255.f) alpha:1]

#import "RSAlertViewController.h"

@interface RSAlertViewController ()

@property (nonatomic, weak) IBOutlet UILabel *lblTitle;
@property (nonatomic, weak) IBOutlet UILabel *lblMessage;

/* views */

@property (nonatomic, strong) UIView *backGroundView;                // transparent background View
@property (weak, nonatomic) IBOutlet UIView *mainContainerView;

@property (weak, nonatomic) IBOutlet UIStackView *stackView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *stackViewHeightConstraint;

@property (nonatomic, strong) NSString *alertTitle;                  // title
@property (nonatomic, strong) NSString *alertMessage;                // message
@property (nonatomic, strong) NSMutableArray *buttonsTitles;         // array of buttons

@property (nonatomic, copy) void(^alertViewButtonClicked)(NSUInteger buttonIndex);

@end

@implementation RSAlertViewController

#pragma mark - Singleton instance

+(instancetype)sharedInstance {
    
    RSAlertViewController *_sharedInstance;
    if(!_sharedInstance){
        _sharedInstance = [[RSAlertViewController alloc] initWithNibName:NSStringFromClass([RSAlertViewController class]) bundle:nil];
    }
    return _sharedInstance;
}

#pragma mark- Life Cycle

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if(self){
        [self initialize];
    }
    return self;
}

-(void)initialize {
    
    // set presentation style
    self.modalPresentationStyle = UIModalPresentationOverCurrentContext;
    self.textAlignment = NSTextAlignmentCenter;
}

-(void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupLayout];
    
    self.lblTitle.text = self.alertTitle;
    self.lblMessage.text = self.alertMessage;
}

#pragma mark- Methods

-(instancetype)showAlertWithTitle:(NSString *)title message:(NSString *)message buttons:(NSArray *)buttonTitles fromViewController:(UIViewController *)viewController withActionHandler:(void (^)(NSUInteger))actionHandler {
    
    self.alertTitle = title;
    self.alertMessage = message;
    self.buttonsTitles = [buttonTitles mutableCopy];
    self.alertViewButtonClicked = [actionHandler copy];
    
    // present controller
    [viewController presentViewController:self animated:NO completion:nil];
    
    return self;
}

-(void)setupLayout {
    
    // add background view
    [self.view insertSubview:self.backGroundView atIndex:0];
    
    // prepare buttons
    [self prepareButtons];

    self.mainContainerView.backgroundColor = kDefaultBackgroundColor;
    self.lblMessage.textAlignment = self.textAlignment;
    
    self.mainContainerView.layer.cornerRadius = 11.0f;
    self.mainContainerView.layer.masksToBounds = YES;
}

-(void)prepareButtons {
 
    /* change style to vertical if buttons are more than two */
    if(self.buttonsTitles.count > 2){
        self.stackView.axis = UILayoutConstraintAxisVertical;
        self.stackViewHeightConstraint.constant = self.stackViewHeightConstraint.constant * self.buttonsTitles.count;
    }
    
    [self.buttonsTitles enumerateObjectsUsingBlock:^(NSString * _Nonnull title, NSUInteger idx, BOOL * _Nonnull stop) {
        
        // create new button with properties
        UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
        
        [button setTitle:title forState:UIControlStateNormal];
        [button setTag:idx];
        [button addTarget:self action:@selector(alertButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
        [button.titleLabel setFont:[UIFont systemFontOfSize:16 weight:0.2]];
        [button setBackgroundColor:kDefaultBackgroundColor];
        
        if(self.buttonsColor){
            [button setTitleColor:self.buttonsColor forState:UIControlStateNormal];
            [button setTitleColor:self.buttonsColor forState:UIControlStateHighlighted];
        }
        
        [self.stackView insertArrangedSubview:button atIndex:idx];
    }];
}

-(void)setButtonsTitleColor:(UIColor *)color {
    
    for (UIView *subView in self.stackView.subviews) {
        
        if([subView isKindOfClass:[UIButton class]]){
            UIButton *button = (UIButton *)subView;
            
            [button setTitleColor:color forState:UIControlStateNormal];
            [button setTitleColor:color forState:UIControlStateHighlighted];
        }
    }
}

#pragma mark- Actions

-(void)backgroundViewTapped:(UITapGestureRecognizer *)gestureRecognizer {
    
    if(self.dismissOnTapOutside){
        [self dismissViewControllerAnimated:NO completion:nil];
    }
}

-(void)alertButtonClicked:(UIButton *)sender {
    
    [self dismissViewControllerAnimated:NO completion:^{
        
        if(self.alertViewButtonClicked){
            self.alertViewButtonClicked(sender.tag);
        }
    }];
}

#pragma mark- Getter/Setter

-(UIView *)backGroundView {
    
    if(!_backGroundView){
        
        _backGroundView = [[UIView alloc] init];
        _backGroundView.frame = [UIScreen mainScreen].bounds;
        _backGroundView.backgroundColor = [[UIColor darkGrayColor] colorWithAlphaComponent:0.4];
        
        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(backgroundViewTapped:)];
        [_backGroundView addGestureRecognizer:tapGesture];
        
    }
    return _backGroundView;
}

- (NSString *)alertTitle {
    
    if(!_alertTitle){
        _alertTitle = @"";
    }
    return _alertTitle;
}

-(NSString *)alertMessage {
    
    if(!_alertMessage){
        _alertMessage = @"";
    }
    return _alertMessage;
}

-(void)setTextAlignment:(NSTextAlignment)textAlignment {
    
    _textAlignment = textAlignment;
    self.lblMessage.textAlignment = _textAlignment;
}

- (void)setTitleColor:(UIColor *)titleColor {
    
    _titleColor = titleColor;
    [self.lblTitle setTextColor:titleColor];
}

- (void)setTextColor:(UIColor *)textColor {
    
    _textColor = textColor;
    [self.lblMessage setTextColor:_textColor];
}

-(void)setButtonsColor:(UIColor *)buttonsColor {
    
    _buttonsColor = buttonsColor;
    [self setButtonsTitleColor:_buttonsColor];
}

@end
