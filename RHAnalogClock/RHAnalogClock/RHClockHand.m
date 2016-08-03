//
//  RHClockHand.m
//  RHAnalogClock
//
//  Created by Robert Herdzik on 2/28/15.
//  Copyright (c) 2015 Ro. All rights reserved.
//

#import "RHClockHand.h"
#import "Globals.h"

@interface RHClockHand() {
    
}

@end

@implementation RHClockHand

- (instancetype)initWithCoder:(NSCoder *)coder {
    self = [super initWithCoder:coder];
    if (self) {
        [self initComponents];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self initComponents];
    }
    return self;
}

- (void)initComponents {
    [self defaultValues];
    self.backgroundColor = self.color;
    
    [self.layer setAnchorPoint:CGPointMake(0.5, 0.)];
    self.layer.masksToBounds = YES;
}

- (void)defaultValues {
    self.color = [UIColor grayColor];
}

#pragma mark -
#pragma mark - Drawing 

- (void)drawRect:(CGRect)rect {
    //    UIView *testView = [[UIView alloc] initWithFrame:CGRectMake(self.frame.size.width - 5, self.frame.size.height, 10, 10)];
    //    testView.backgroundColor = [UIColor greenColor];
    //    [self addSubview:testView];
}

#pragma mark -
#pragma mark - Setters/Getters 

- (void)setColor:(UIColor *)color {
    _color = color;
    self.backgroundColor = _color;
}

#pragma mark - 
#pragma mark - Public

- (void)rotateWithAngle:(float)angle andAnimation:(BOOL)animation {
    CGAffineTransform transform = CGAffineTransformRotate(CGAffineTransformIdentity, DEGREES_TO_RADIANS(angle));
    
    if (animation)
        [UIView animateWithDuration:0.8
                         animations:^{
                             self.transform = transform;
                         }];
    else
        self.transform = transform;
}


@end
