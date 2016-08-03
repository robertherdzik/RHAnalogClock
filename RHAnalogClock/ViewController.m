//
//  ViewController.m
//  RHAnalogClock
//
//  Created by Robert Herdzik on 2/28/15.
//  Copyright (c) 2015 Ro. All rights reserved.
//

#import "ViewController.h"
#import "RHClockAnalogView.h"


@interface ViewController ()

@property (weak, nonatomic) IBOutlet RHClockViewBaseMechanism *clockView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
      
    [self.clockView startPositionWithAnimation:YES];
    [self.clockView runClock];
}

- (IBAction)startClock:(id)sender {
    [self.clockView runClock];
}

- (IBAction)stopClock:(id)sender {
    [self.clockView stopClock];
}

@end
