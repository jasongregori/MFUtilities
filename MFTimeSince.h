//
//  MFTimeSince.h
//
//  Created by Jason Gregori on 9/15/11.
//  Copyright 2011 Jason Gregori. All rights reserved.
//

// @mf: Gives you the time passed since a date as a string; fully and easily customizable

/*
 
 Time is measured in different units. An hour is a unit with 60*60 seconds in it.
 All formats are passed the number of units as an int (%i).
 Remember, upto *is not* inclusive. So if you put up to 5 minutes thats any time up to, but not including, 5 minutes.
 If no format is found that fits a time, the format for the highest units will be used.
 
 Example:

     [MFTimeSince setFormat:@"now" forUpToThisManyUnits:5 secondsInUnit:60]; // up to 5 minutes
     [MFTimeSince setFormat:@"%i minutes" forUpToThisManyUnits:60 secondsInUnit:60]; // up to 60 minutes
     [MFTimeSince setFormat:@"1 hour" forUpToThisManyUnits:2 secondsInUnit:60*60]; // up to (but not including) 2 hours
     [MFTimeSince setFormat:@"%i hours" forUpToThisManyUnits:24 secondsInUnit:60*60]; // up to 24 hours
     [MFTimeSince setFormat:@"1 day" forUpToThisManyUnits:2 secondsInUnit:24*60*60]; // up to (but not including) 2 days
     [MFTimeSince setFormat:@"%i days" forUpToThisManyUnits:DBL_MAX secondsInUnit:24*60*60]; // goes forever

 */

#import <Foundation/Foundation.h>

@interface MFTimeSince : NSObject

// Use these for the global MFTimeSince
+ (void)setFormat:(NSString *)format forUpToThisManyUnits:(double)upto secondsInUnit:(NSUInteger)secondsInUnit;
+ (NSString *)timeSince:(NSDate *)date;
+ (NSString *)timeSinceTimestamp:(NSTimeInterval)timestamp;

// You may use these if you need more than one MFTimeSince instance
- (void)setFormat:(NSString *)format forUpToThisManyUnits:(double)upto secondsInUnit:(NSUInteger)secondsInUnit;
- (NSString *)timeSince:(NSDate *)date;
- (NSString *)timeSinceTimestamp:(NSTimeInterval)timestamp;

@end
