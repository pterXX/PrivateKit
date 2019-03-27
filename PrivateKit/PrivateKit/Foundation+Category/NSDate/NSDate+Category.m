//
//  NSDate+Category.m
//  KRhinoMail
//
//  Created by RPK on 2017/7/19.
//  Copyright © 2017年 EIMS. All rights reserved.
//

#import "NSDate+Category.h"

@implementation NSDate (Category)

+ (NSDateComponents*)deltaFrom:(NSDate *)from
{
    // 初始化日历
    NSCalendar * calendar = [NSCalendar currentCalendar];
    
    // 设置日历单元
    NSCalendarUnit unit = NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear | NSCalendarUnitHour |NSCalendarUnitMinute | NSCalendarUnitSecond;
    
    // 返回比较你的数据时间与现在时间的差值
    return [calendar components:unit fromDate:from toDate:[NSDate date] options:0];
}

/**
 获取当前时间

 @param dateFormat 时间格式
 @return 时间字符串
 */
+ (NSString *)getCurrentStringTimesWithdateFormat:(NSString *)dateFormat
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    // 设置你想要的格式,hh与HH的区别:分别表示12小时制,24小时制
    [formatter setDateFormat:dateFormat];
    // 现在时间,你可以输出来看下是什么格式
    NSDate *datenow = [NSDate date];
    // 将nsdate按formatter格式转成nsstring
    NSString *currentTimeString = [formatter stringFromDate:datenow];
    
    return currentTimeString;
}

/**
 获取当前时间
 */
+ (NSDate *)getCurrentDateTimes
{
    // 获得时间对象
    NSDate *date = [NSDate date];
    // 获得系统的时区
    NSTimeZone *zone = [NSTimeZone systemTimeZone];
    // 以秒为单位返回当前时间与系统格林尼治时间的差
    NSTimeInterval time = [zone secondsFromGMTForDate:date];
    // 然后把差的时间加上,就是当前系统准确的时间
    NSDate *dateNow = [date dateByAddingTimeInterval:time];
    
    return dateNow;
}

/*
 *例如  2017 - 10 - 01
 *     年份值  月份  日
 */
//判断是否是今年
- (BOOL)isThisYear
{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    //现在日期的年份值
    NSInteger nowYear = [calendar component:NSCalendarUnitYear fromDate:[NSDate date]];
    //传入对象的年份值
    NSInteger selfYear = [calendar component:NSCalendarUnitYear fromDate:self];
    
    return nowYear == selfYear;
    
}

// 判断是否是今天
- (BOOL)isToday
{
    NSDateFormatter * fmt = [[NSDateFormatter alloc]init];
    fmt.dateFormat = @"yyyy-MM-dd";
    //今天的日期
    NSString * nowString = [fmt stringFromDate:[NSDate date]];
    //传入对象的日期
    NSString * selfString = [fmt stringFromDate:self];
    
    return [nowString isEqualToString:selfString];
    
}

// 判断是否是昨天
- (BOOL)isYesterday
{
    NSDateFormatter * fmt = [[NSDateFormatter alloc]init];
    fmt.dateFormat = @"yyyy-MM-dd";
    //今天的日期
    NSDate *nowDate = [fmt dateFromString:[fmt stringFromDate:[NSDate date]]];
    //传入对象的日期
    NSDate *selfDate = [fmt dateFromString:[fmt stringFromDate:self]];
    //二者差值
    NSCalendar * calender = [NSCalendar currentCalendar];
    NSDateComponents * cmps = [calender components:NSCalendarUnitDay | NSCalendarUnitMonth |  NSCalendarUnitYear fromDate:selfDate toDate:nowDate options:0];
    
    return cmps.year == 0 && cmps.month == 0 && cmps.day == 1;
    
}

/**
 是否在一周之内
 */
- (BOOL)isWeek
{
    NSDateFormatter * fmt = [[NSDateFormatter alloc] init];
    fmt.dateFormat = @"yyyy-MM-dd";
    //今天的日期
    NSDate *nowDate = [fmt dateFromString:[fmt stringFromDate:[NSDate date]]];
    //传入对象的日期
    NSDate *selfDate = [fmt dateFromString:[fmt stringFromDate:self]];
    //二者差值
    NSCalendar * calender = [NSCalendar currentCalendar];
    NSDateComponents * cmps = [calender components:NSCalendarUnitDay | NSCalendarUnitMonth |  NSCalendarUnitYear fromDate:selfDate toDate:nowDate options:0];
    
    return cmps.year == 0 && cmps.month == 0 && cmps.day == 7;
}

/**
 根据不同格式，格式化时间戳

 @param date 时间戳
 @return 格式化后的时间
 */
+ (NSString *)dateFormatter:(NSDate *)date
{
    // 日期格式化
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];

    if (date.isThisYear)
    {
        if (date.isToday)
        {
            NSCalendar *cal = [NSCalendar currentCalendar];
            NSDateComponents *components = [cal components:NSCalendarUnitHour fromDate:date];
            NSInteger currHour = [components hour];
            
            if (currHour < 6) {
                fmt.dateFormat = @"凌晨 HH:mm";
            }else if (currHour >= 6 && currHour < 12) {
                fmt.dateFormat = @"上午 HH:mm";
            }else if (currHour >= 12 && currHour < 18) {
                fmt.dateFormat = @"下午 HH:mm";
            }else {
                fmt.dateFormat = @"晚上 HH:mm";
            }
            
            return [fmt stringFromDate:date];
            
        }else {
            // 其他
            fmt.dateFormat = @"MM-dd HH:mm";
            return [fmt stringFromDate:date];
        }
    }else {
        // 非今年
        fmt.dateFormat = @"yyyy-MM-dd HH:mm";
        return [fmt stringFromDate:date];
    }
}

// 获取当前时间戳
+ (NSString *)getCurrentTimestamp
{
    NSDate *date = [NSDate dateWithTimeIntervalSinceNow:0];     // 获取当前时间0秒后的时间
    NSTimeInterval time = [date timeIntervalSince1970] * 1000;    // 精确到毫秒
    NSString *timeString = [NSString stringWithFormat:@"%.0f", time];
    
    return timeString;
}

+(NSString *)getNowTimestamp:(NSDate *)date{
    //时间转时间戳的方法:
    return [[NSNumber numberWithDouble:[date timeIntervalSince1970]] stringValue];
}



#pragma mark - # 基本时间参数
- (NSUInteger)year {
    NSCalendar *calendar = [NSCalendar currentCalendar];
#if __IPHONE_OS_VERSION_MIN_REQUIRED >= __IPHONE_8_0
    NSDateComponents *dayComponents = [calendar components:(NSCalendarUnitYear) fromDate:self];
#else
    NSDateComponents *dayComponents = [calendar components:(NSYearCalendarUnit) fromDate:self];
#endif
    return [dayComponents year];
}

- (NSUInteger)month {
    NSCalendar *calendar = [NSCalendar currentCalendar];
#if __IPHONE_OS_VERSION_MIN_REQUIRED >= __IPHONE_8_0
    NSDateComponents *dayComponents = [calendar components:(NSCalendarUnitMonth) fromDate:self];
#else
    NSDateComponents *dayComponents = [calendar components:(NSMonthCalendarUnit) fromDate:self];
#endif
    return [dayComponents month];
}

- (NSUInteger)day {
    NSCalendar *calendar = [NSCalendar currentCalendar];
#if __IPHONE_OS_VERSION_MIN_REQUIRED >= __IPHONE_8_0
    NSDateComponents *dayComponents = [calendar components:(NSCalendarUnitDay) fromDate:self];
#else
    NSDateComponents *dayComponents = [calendar components:(NSDayCalendarUnit) fromDate:self];
#endif
    return [dayComponents day];
}


- (NSUInteger)hour {
    NSCalendar *calendar = [NSCalendar currentCalendar];
#if __IPHONE_OS_VERSION_MIN_REQUIRED >= __IPHONE_8_0
    NSDateComponents *dayComponents = [calendar components:(NSCalendarUnitHour) fromDate:self];
#else
    NSDateComponents *dayComponents = [calendar components:(NSHourCalendarUnit) fromDate:self];
#endif
    return [dayComponents hour];
}

- (NSUInteger)minute {
    NSCalendar *calendar = [NSCalendar currentCalendar];
#if __IPHONE_OS_VERSION_MIN_REQUIRED >= __IPHONE_8_0
    NSDateComponents *dayComponents = [calendar components:(NSCalendarUnitMinute) fromDate:self];
#else
    NSDateComponents *dayComponents = [calendar components:(NSMinuteCalendarUnit) fromDate:self];
#endif
    return [dayComponents minute];
}

- (NSUInteger)second {
    NSCalendar *calendar = [NSCalendar currentCalendar];
#if __IPHONE_OS_VERSION_MIN_REQUIRED >= __IPHONE_8_0
    NSDateComponents *dayComponents = [calendar components:(NSCalendarUnitSecond) fromDate:self];
#else
    NSDateComponents *dayComponents = [calendar components:(NSSecondCalendarUnit) fromDate:self];
#endif
    return [dayComponents second];
}

- (NSUInteger)weekday
{
    NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents *comps = [gregorian components:(NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear | NSCalendarUnitWeekday) fromDate:self];
    NSInteger weekday = [comps weekday] - 1;
    weekday = weekday == 0 ? 7 : weekday;
    return weekday;
}

- (NSUInteger)dayInMonth
{
    switch (self.month) {
        case 1: case 3: case 5: case 7: case 8: case 10: case 12:
            return 31;
        case 2:
            return self.isLeapYear ? 29 : 28;
    }
    return 30;
}

- (BOOL)isLeapYear {
    if ((self.year % 4  == 0 && self.year % 100 != 0) || self.year % 400 == 0) {
        return YES;
    }
    return NO;
}

#pragma mark - # 日期格式化
/// YYYY年MM月dd日
- (NSString *)formatYMD
{
    return [NSString stringWithFormat:@"%lu年%02lu月%02lu日", (unsigned long)self.year, (unsigned long)self.month, (unsigned long)self.day];
}

/// 自定义分隔符
- (NSString *)formatYMDWithSeparate:(NSString *)separate
{
    return [NSString stringWithFormat:@"%lu%@%02lu%@%02lu", (unsigned long)self.year, separate, (unsigned long)self.month, separate, (unsigned long)self.day];
}

/// MM月dd日
- (NSString *)formatMD
{
    return [NSString stringWithFormat:@"%02lu月%02lu日", (unsigned long)self.month, (unsigned long)self.day];
}

/// 自定义分隔符
- (NSString *)formatMDWithSeparate:(NSString *)separate
{
    return [NSString stringWithFormat:@"%02lu%@%02lu", (unsigned long)self.month, separate, (unsigned long)self.day];
}

/// HH:MM:SS
- (NSString *)formatHMS
{
    return [NSString stringWithFormat:@"%02lu:%02lu:%02lu", (unsigned long)self.hour, (unsigned long)self.minute, (unsigned long)self.second];
}

/// HH:MM
- (NSString *)formatHM
{
    return [NSString stringWithFormat:@"%02lu:%02lu", (unsigned long)self.hour, (unsigned long)self.minute];
}

/// 星期几
- (NSString *)formatWeekday
{
    switch([self weekday]) {
        case 1:
            return NSLocalizedString(@"星期一", nil);
        case 2:
            return NSLocalizedString(@"星期二", nil);
        case 3:
            return NSLocalizedString(@"星期三", nil);
        case 4:
            return NSLocalizedString(@"星期四", nil);
        case 5:
            return NSLocalizedString(@"星期五", nil);
        case 6:
            return NSLocalizedString(@"星期六", nil);
        case 7:
            return NSLocalizedString(@"星期天", nil);
        default:
            break;
    }
    return @"";
}

/// 月份
- (NSString *)formatMonth {
    switch(self.month) {
        case 1:
            return NSLocalizedString(@"一月", nil);
        case 2:
            return NSLocalizedString(@"二月", nil);
        case 3:
            return NSLocalizedString(@"三月", nil);
        case 4:
            return NSLocalizedString(@"四月", nil);
        case 5:
            return NSLocalizedString(@"五月", nil);
        case 6:
            return NSLocalizedString(@"六月", nil);
        case 7:
            return NSLocalizedString(@"七月", nil);
        case 8:
            return NSLocalizedString(@"八月", nil);
        case 9:
            return NSLocalizedString(@"九月", nil);
        case 10:
            return NSLocalizedString(@"十月", nil);
        case 11:
            return NSLocalizedString(@"十一月", nil);
        case 12:
            return NSLocalizedString(@"十二月", nil);
        default:
            break;
    }
    return @"";
}


@end
