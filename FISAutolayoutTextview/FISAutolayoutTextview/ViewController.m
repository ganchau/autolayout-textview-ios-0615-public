//
//  ViewController.m
//  FISAutolayoutTextview
//
//  Created by Gan Chau on 6/29/15.
//  Copyright (c) 2015 Gantastic App. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UIButton *leftButton;
@property (weak, nonatomic) IBOutlet UIButton *rightButton;
@property (weak, nonatomic) IBOutlet UITextView *myTextView;
@property (strong, nonatomic) NSLayoutConstraint *textViewBottom;

@end

@implementation ViewController

-(void)viewWillAppear:(BOOL)animated
{
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(orientationChanged:)
                                                 name:UIDeviceOrientationDidChangeNotification
                                               object:nil];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    [self.view removeConstraints:self.view.constraints];
    self.view.translatesAutoresizingMaskIntoConstraints = NO;
    [self.leftButton removeConstraints:self.leftButton.constraints];
    self.leftButton.translatesAutoresizingMaskIntoConstraints = NO;
    [self.rightButton removeConstraints:self.rightButton.constraints];
    self.rightButton.translatesAutoresizingMaskIntoConstraints = NO;
    [self.myTextView removeConstraints:self.myTextView.constraints];
    self.myTextView.translatesAutoresizingMaskIntoConstraints = NO;
    
    NSLayoutConstraint *leftButtonLeft = [NSLayoutConstraint constraintWithItem:self.leftButton
                                                                      attribute:NSLayoutAttributeLeft
                                                                      relatedBy:NSLayoutRelationEqual
                                                                         toItem:self.view
                                                                      attribute:NSLayoutAttributeLeft
                                                                     multiplier:1.0
                                                                       constant:10.0];
    
    NSLayoutConstraint *leftButtonBottom = [NSLayoutConstraint constraintWithItem:self.leftButton
                                                                        attribute:NSLayoutAttributeBottom
                                                                        relatedBy:NSLayoutRelationEqual
                                                                           toItem:self.view
                                                                        attribute:NSLayoutAttributeBottom
                                                                       multiplier:1.0
                                                                         constant:-10.0];
    
    NSLayoutConstraint *rightButtonRight = [NSLayoutConstraint constraintWithItem:self.rightButton
                                                                        attribute:NSLayoutAttributeRight
                                                                        relatedBy:NSLayoutRelationEqual
                                                                           toItem:self.view
                                                                        attribute:NSLayoutAttributeRight
                                                                       multiplier:1.0
                                                                         constant:-10.0];
    NSLayoutConstraint *rightButtonBottom = [NSLayoutConstraint constraintWithItem:self.rightButton
                                                                        attribute:NSLayoutAttributeBottom
                                                                        relatedBy:NSLayoutRelationEqual
                                                                           toItem:self.view
                                                                        attribute:NSLayoutAttributeBottom
                                                                       multiplier:1.0
                                                                         constant:-10.0];
    
    NSLayoutConstraint *textViewTop = [NSLayoutConstraint constraintWithItem:self.myTextView
                                                                   attribute:NSLayoutAttributeTop
                                                                   relatedBy:NSLayoutRelationEqual
                                                                      toItem:self.view
                                                                   attribute:NSLayoutAttributeTop
                                                                  multiplier:1.0
                                                                    constant:20.0];
    
    NSLayoutConstraint *textViewLeft = [NSLayoutConstraint constraintWithItem:self.myTextView
                                                                    attribute:NSLayoutAttributeLeft
                                                                    relatedBy:NSLayoutRelationEqual
                                                                       toItem:self.view
                                                                    attribute:NSLayoutAttributeLeft
                                                                   multiplier:1.0
                                                                     constant:10.0];
    
    NSLayoutConstraint *textViewRight = [NSLayoutConstraint constraintWithItem:self.myTextView
                                                                     attribute:NSLayoutAttributeRight
                                                                     relatedBy:NSLayoutRelationEqual
                                                                        toItem:self.view
                                                                     attribute:NSLayoutAttributeRight
                                                                    multiplier:1.0
                                                                      constant:-10.0];
    
    self.textViewBottom = [NSLayoutConstraint constraintWithItem:self.myTextView
                                                       attribute:NSLayoutAttributeBottom
                                                       relatedBy:NSLayoutRelationEqual
                                                          toItem:self.leftButton
                                                       attribute:NSLayoutAttributeTop
                                                      multiplier:1.0
                                                        constant:-20.0];
    
    [self.view addConstraints:@[rightButtonRight, rightButtonBottom]];
    [self.view addConstraints:@[leftButtonLeft, leftButtonBottom]];
    [self.view addConstraints:@[textViewLeft, textViewRight, textViewTop, self.textViewBottom]];
    
    [self adjustForIPhone4];
}

- (void)adjustForIPhone4
{
    if (self.view.frame.size.height == 480) {
        self.textViewBottom.constant = -30.0;
        NSLog(@"iPhone 4");
    }
}

- (void)orientationChanged:(NSNotification *)notification
{
    [self adjustViewsForOrientation:[[UIApplication sharedApplication] statusBarOrientation]];
}

- (void) adjustViewsForOrientation:(UIInterfaceOrientation) orientation
{
    
    switch (orientation)
    {
        case UIInterfaceOrientationPortrait:
        case UIInterfaceOrientationPortraitUpsideDown:
        {
            //load the portrait view
            self.textViewBottom.constant = -20.0;
            [self adjustForIPhone4];
            NSLog(@"PORTRAIT");
        }
            
            break;
        case UIInterfaceOrientationLandscapeLeft:
        case UIInterfaceOrientationLandscapeRight:
        {
            //load the landscape view
            self.textViewBottom.constant = -10.0;
            NSLog(@"LANDSCAPE");
            
        }
            break;
        case UIInterfaceOrientationUnknown:break;
    }
}

-(void)viewDidDisappear:(BOOL)animated
{
    [[NSNotificationCenter defaultCenter]removeObserver:self name:UIDeviceOrientationDidChangeNotification object:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
