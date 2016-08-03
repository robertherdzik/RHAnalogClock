//
//  RHAnalogClockAnalogView.m
//  RHAnalogClock
//
//  Created by Robert Herdzik on 3/4/15.
//  Copyright (c) 2015 Ro. All rights reserved.
//

#import "RHClockAnalogView.h"
#import "RHClockHand.h"


@implementation RHClockAnalogView

#pragma mark -
#pragma mark - Hands Customization

- (void)initAndSetHoursHandLayout {
    // HourHand
    CGSize handSize = CGSizeMake(6, self.frame.size.height/4);
    CGRect calculatedFrame = [self getHandRectAccordingToSize:handSize];
    self.hourHand = [[RHClockHand alloc] initWithFrame:calculatedFrame];
    self.hourHand.layer.cornerRadius = 3;
    self.hourHand.color = [UIColor grayColor];
    [self.layer addSublayer:self.hourHand.layer];
}

- (void)initAndSetMinutesHandLayout {
    // MinHand
    CGSize handSize = CGSizeMake(3, self.frame.size.height/3);
    CGRect calculatedFrame = [self getHandRectAccordingToSize:handSize];
    self.minHand = [[RHClockHand alloc] initWithFrame:calculatedFrame];
    self.minHand.layer.cornerRadius = 2;
    self.minHand.color = [UIColor grayColor];
    [self.layer addSublayer:self.minHand.layer];
}

- (void)initAndSetSecondsHandLayout {
    // SecHand
    CGSize handSize = CGSizeMake(1, self.frame.size.height/2);
    CGRect calculatedFrame = [self getHandRectAccordingToSize:handSize];
    self.secHand = [[RHClockHand alloc] initWithFrame:calculatedFrame];
    self.secHand.layer.cornerRadius = 1;
    self.secHand.color = [UIColor redColor];
    [self.secHand.layer setAnchorPoint:CGPointMake(0.5, 0.1)];
    [self.layer addSublayer:self.secHand.layer];
}

#pragma mark -
#pragma mark - Private

- (CGRect)getHandRectAccordingToSize:(CGSize)handSize {
    return CGRectMake(self.centerPoint.x - handSize.width/2, self.centerPoint.y - handSize.height/2, handSize.width, handSize.height);
}

@end
