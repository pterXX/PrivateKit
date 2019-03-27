//
//  NSDate+Category.h
//  KRhinoMail
//
//  Created by RPK on 2017/7/19.
//  Copyright © 2017年 EIMS. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (Category)

/**
 *比较from和self的时间差值
 */
+ (NSDateComponents *)deltaFrom:(NSDate *)from;

/**
 获取当前时间
 
 @param dateFormat 时间格式
 @return 时间字符串
 */
+ (NSString *)getCurrentStringTimesWithdateFormat:(NSString *)dateFormat;

/**
 获取当前时间
 */
+ (NSDate *)getCurrentDateTimes;

/**
 *是否为今年
 */
- (BOOL)isThisYear;

/**
 *是否为今天
 */
- (BOOL)isToday;

/**
 *是否为昨天
 */
- (BOOL)isYesterday;

/**
 是否在一周内
 */
- (BOOL)isWeek;

/**
 根据不同格式，格式化时间戳
 
 @param date 时间戳
 @return 格式化后的时间
 */
+ (NSString *)dateFormatter:(NSDate *)date;

// 获取当前时间戳
+ (NSString *)getCurrentTimestamp;
//  获取指定时间的时间戳
+(NSString *)getNowTimestamp:(NSDate *)date;



#pragma mark - 基本时间参数
@property (nonatomic, assign, readonly) NSUInteger year;
@property (nonatomic, assign, readonly) NSUInteger month;
@property (nonatomic, assign, readonly) NSUInteger day;
@property (nonatomic, assign, readonly) NSUInteger hour;
@property (nonatomic, assign, readonly) NSUInteger minute;
@property (nonatomic, assign, readonly) NSUInteger second;
/// 时期几，整数
@property (nonatomic, assign, readonly) NSUInteger weekday;
/// 当前月份的天数
@property (nonatomic, assign, readonly) NSUInteger dayInMonth;
/// 是不是闰年
@property (nonatomic, assign, readonly) BOOL isLeapYear;

#pragma mark - 日期格式化
/// YYYY年MM月dd日
- (NSString *)formatYMD;
/// 自定义分隔符
- (NSString *)formatYMDWithSeparate:(NSString *)separate;
/// MM月dd日
- (NSString *)formatMD;
/// 自定义分隔符
- (NSString *)formatMDWithSeparate:(NSString *)separate;
/// HH:MM:SS
- (NSString *)formatHMS;
/// HH:MM
- (NSString *)formatHM;
/// 星期几
- (NSString *)formatWeekday;
/// 月份
- (NSString *)formatMonth;

@end
