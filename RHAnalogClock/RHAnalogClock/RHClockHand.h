//
//  RHClockHand.h
//  RHAnalogClock
//
//  Created by Robert Herdzik on 2/28/15.
//  Copyright (c) 2015 Ro. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RHClockHand : UIView

@property (nonatomic) UIColor *color;

- (void)rotateWithAngle:(float)angle
           andAnimation:(BOOL)animation;

@end
