//
//  RHAnagloClockView.h
//  RHAnalogClock
//
//  Created by Robert Herdzik on 2/28/15.
//  Copyright (c) 2015 Ro. All rights reserved.
//

#import <UIKit/UIKit.h>

@class RHClockHand;

@interface RHClockViewBaseMechanism : UIView

@property(nonatomic) RHClockHand *hourHand;
@property(nonatomic) RHClockHand *minHand;
@property(nonatomic) RHClockHand *secHand;

// Center point of watch
@property(nonatomic) CGPoint centerPoint;


/// The background color of the clock's face.
@property (strong, nonatomic) UIColor *faceBackgroundColor;

/// The alpha of the clock's face.
@property (nonatomic) CGFloat faceBackgroundAlpha;

/// The color of the clock's border.
@property (strong, nonatomic) UIColor *borderColor;

/// The alpha of the clock's border.
@property (nonatomic) CGFloat borderAlpha;

/// The width of the clock's border.
@property (nonatomic) CGFloat borderWidth;

#pragma mark - Center Dot properties
@property (nonatomic) UIColor *dotColor;
@property (nonatomic) CGSize dotSize;
@property (nonatomic) CGFloat dotAlpha;
@property (nonatomic) CGFloat dotBorderWidth;

/// Digits
@property (nonatomic) UIFont *digitFont;
@property (nonatomic) UIColor *digitColor;

- (void)startPositionWithAnimation:(BOOL)animation;

- (void)runClock;
- (void)stopClock;

#pragma mark - Method which have to be implemented in SUBCLASS!!
- (void)initAndSetHoursHandLayout;
- (void)initAndSetMinutesHandLayout;
- (void)initAndSetSecondsHandLayout;



@end
