//
//  NSString+Size.h
//  KXiniuCloud
//
//  Created by eims on 2018/5/29.
//  Copyright © 2018年 EIMS. All rights reserved.
//

#import <UIKit/UIKit.h>
@interface NSString (Size)
- (CGSize)kk_SizeWithFont:(UIFont *)font;

- (CGSize)kk_SizeWithFont:(UIFont *)font constrainedToSize:(CGSize)size;
- (CGSize)kk_SizeWithFont:(UIFont *)font constrainedToWidth:(CGFloat)width;

- (CGSize)kk_SizeWithFont:(UIFont *)font constrainedToSize:(CGSize)size lineBreakMode:(NSLineBreakMode)lineBreakMode;
- (CGSize)kk_SizeWithFont:(UIFont *)font constrainedToWidth:(CGFloat)width lineBreakMode:(NSLineBreakMode)lineBreakMode;

- (CGSize)kk_SizeWithFont:(UIFont *)font constrainedToSize:(CGSize)size lineBreakMode:(NSLineBreakMode)lineBreakMode lineSpace:(CGFloat)lineSpace;
@end
