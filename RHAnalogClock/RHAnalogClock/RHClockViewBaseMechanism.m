//
//  RHAnagloClockView.m
//  RHAnalogClock
//
//  Created by Robert Herdzik on 2/28/15.
//  Copyright (c) 2015 Ro. All rights reserved.
//

#import "RHClockViewBaseMechanism.h"
#import "RHClockHand.h"
#import "Globals.h"

struct TimeStruct {
    NSInteger hour;
    NSInteger minutes;
    NSInteger seconds;
};

@interface RHClockViewBaseMechanism() {

    NSTimer *clockHeart;
}

@end

@implementation RHClockViewBaseMechanism

- (instancetype)initWithCoder:(NSCoder *)coder {
    self = [super initWithCoder:coder];
    NSAssert([self class] != [RHClockViewBaseMechanism class], @"This is an abstract class");
    if (self) {
        [self baseInit];
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    NSAssert([self class] != [RHClockViewBaseMechanism class], @"This is an abstract class");
    if (self) {
        [self baseInit];
    }
    return self;
}

- (void)baseInit {
    self.backgroundColor = [UIColor clearColor];
    _faceBackgroundColor = [UIColor colorWithRed:70./255.0 green:223./255.0 blue:0./255 alpha:0.6];
    _faceBackgroundAlpha = 0.95f;
    
    _borderColor = [UIColor whiteColor];
    _borderAlpha = 1.0f;
    _borderWidth = 3;
    
    // Center Dot
    _dotSize = CGSizeMake(4, 4);
    _dotColor = [UIColor whiteColor];
    _dotAlpha = 0.5f;
    _dotBorderWidth = 1.f;
    
    // Digits
    _digitColor = [UIColor whiteColor];
    _digitFont  = [UIFont fontWithName:@"HelveticaNeue-Thin" size:20];
}

- (void)drawRect:(CGRect)rect {
    _centerPoint = CGPointMake(rect.size.width/2, rect.size.height/2);
    
    [self drawClockFaceAccordingToGivenRect:rect];
    [self initAndSetHoursHandLayout];
    [self initAndSetMinutesHandLayout];
    [self initAndSetSecondsHandLayout];
}

#pragma mark -
#pragma mark - Setup clock appearance

- (void)initAndSetHoursHandLayout {
    // Have to be implemented in subclass!!
}

- (void)initAndSetMinutesHandLayout {
    // Have to be implemented in subclass!!
}

- (void)initAndSetSecondsHandLayout {
    // Have to be implemented in subclass!!
}

- (void)drawClockFaceAccordingToGivenRect:(CGRect)rect {
    
    // Create clock apearance
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    CGContextAddEllipseInRect(ctx, rect);
    CGContextSetFillColorWithColor(ctx, self.faceBackgroundColor.CGColor);
    CGContextSetAlpha(ctx, self.faceBackgroundAlpha);
    CGContextFillPath(ctx);
    
    // Create clock border
    CGContextAddEllipseInRect(ctx, CGRectMake(rect.origin.x + self.borderWidth/2, rect.origin.y + self.borderWidth/2, rect.size.width - self.borderWidth, rect.size.height - self.borderWidth));
    CGContextSetStrokeColorWithColor(ctx, self.borderColor.CGColor);
    CGContextSetAlpha(ctx, self.borderAlpha);
    CGContextSetLineWidth(ctx,self.borderWidth);
    CGContextStrokePath(ctx);
    
    // Create center point dot
    CGContextAddEllipseInRect(ctx, CGRectMake(_centerPoint.x - self.dotSize.width/2, _centerPoint.y - self.dotSize.height/2, self.dotSize.width, self.dotSize.height));
    CGContextSetStrokeColorWithColor(ctx, self.dotColor.CGColor);
    CGContextSetAlpha(ctx, self.dotAlpha);
    CGContextSetLineWidth(ctx,self.dotBorderWidth);
    CGContextStrokePath(ctx);
    
    // DIGIT DRAWING
    [self drawDigitsForClockFace:rect];

}

- (void)drawDigitsForClockFace:(CGRect)rect {
    CGFloat markingDistanceFromCenter = rect.size.width/2.0f - self.digitFont.lineHeight/4.0f;
    NSInteger offset = 4;
    
    for(unsigned i = 0; i < 12; i ++){
        NSString *hourNumber = [NSString stringWithFormat:@"%@%d", [NSString stringWithFormat:@"%@", i + 1 < 10 ? @" ": @""] , i + 1 ];
        CGFloat labelX = self.centerPoint.x + (markingDistanceFromCenter - self.digitFont.lineHeight/2.0f) * cos((M_PI/180) * (i + offset) * 30 + M_PI);
        CGFloat labelY = self.centerPoint.y + - 1 * (markingDistanceFromCenter - self.digitFont.lineHeight/2.0f) * sin((M_PI/180) * (i + offset) * 30);
        [hourNumber drawInRect:CGRectMake(labelX - self.digitFont.lineHeight/2.0f,labelY - self.digitFont.lineHeight/2.0f, self.digitFont.lineHeight, self.digitFont.lineHeight) withAttributes:@{NSForegroundColorAttributeName: self.digitColor, NSFontAttributeName: self.digitFont}];
    }
}

#pragma mark -
#pragma mark - Getters/Setters


#pragma mark - 
#pragma mark - Clock mechanism

- (void)startPositionWithAnimation:(BOOL)animation {
    [_hourHand rotateWithAngle:180 andAnimation:animation];
    [_minHand rotateWithAngle:180 andAnimation:animation];
    [_secHand rotateWithAngle:180 andAnimation:animation];
}

- (void)updateClock {
    struct TimeStruct timeStruct = [self getCurrentTimeStruct];
    
    [_hourHand rotateWithAngle:[self getHourAngleFromStruct:timeStruct] andAnimation:YES];
    [_minHand rotateWithAngle:[self getMinAngleFromStruct:timeStruct] andAnimation:YES];
    [_secHand rotateWithAngle:[self getSecAngleFromStruct:timeStruct] andAnimation:YES];
}

#pragma mark - 
#pragma mark - Helpers

- (struct TimeStruct)getCurrentTimeStruct {
    NSDateComponents *components = [[NSCalendar currentCalendar] components:NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond
                                                                   fromDate:[NSDate date]];
    struct TimeStruct resultStruct;
    resultStruct.hour = [components hour];
    resultStruct.minutes = [components minute];
    resultStruct.seconds = [components second];
    return resultStruct;
}

- (float)getHourAngleFromStruct:(struct TimeStruct)inputStruct {
    float result = (180 - 30 * inputStruct.hour) * -1;
    return result;
}

- (float)getMinAngleFromStruct:(struct TimeStruct)inputStruct {
    float result = (180 - 6 * inputStruct.minutes) * -1;
    return result;
}

- (float)getSecAngleFromStruct:(struct TimeStruct)inputStruct {
    float result = (180 - 6 * inputStruct.seconds) * -1;
    return result;
}

#pragma mark -
#pragma mark - Public

- (void)runClock {
    if (clockHeart.isValid)
        return;
    
    clockHeart = [NSTimer scheduledTimerWithTimeInterval:1
                                                  target:self
                                                selector:@selector(updateClock)
                                                userInfo:nil
                                                 repeats: YES];
    [clockHeart fire];
}

- (void)stopClock {
    if (![clockHeart isValid])
        return;
    
    [clockHeart invalidate];
    clockHeart = nil;
}



@end
