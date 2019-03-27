//
//  NSString+Size.m
//  KXiniuCloud
//
//  Created by eims on 2018/5/29.
//  Copyright © 2018年 EIMS. All rights reserved.
//

#import "NSString+Size.h"

@implementation NSString (Size)

- (CGSize)kk_SizeWithFont:(UIFont *)font
{
    CGSize textSize = [self sizeWithAttributes:@{NSFontAttributeName : font}];
    CGSize ansSize = CGSizeMake(ceil(textSize.width), ceil(textSize.height));
    return ansSize;
}

- (CGSize)kk_SizeWithFont:(UIFont *)font constrainedToSize:(CGSize)size
{
    CGSize textSize = [self boundingRectWithSize:size
                                         options:NSStringDrawingTruncatesLastVisibleLine|NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading
                                      attributes:@{NSFontAttributeName : font}
                                         context:nil].size;
    CGSize ansSize = CGSizeMake(ceil(textSize.width), ceil(textSize.height));
    return ansSize;
}
- (CGSize)kk_SizeWithFont:(UIFont *)font constrainedToWidth:(CGFloat)width
{
    return [self kk_SizeWithFont:font constrainedToSize:CGSizeMake(width, MAXFLOAT)];
}

- (CGSize)kk_SizeWithFont:(UIFont *)font constrainedToSize:(CGSize)size lineBreakMode:(NSLineBreakMode)lineBreakMode
{
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.lineBreakMode = lineBreakMode;
    NSDictionary *attributes = @{NSFontAttributeName:font, NSParagraphStyleAttributeName:paragraphStyle};
    
    CGSize textSize = [self boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin attributes:attributes context:nil].size;
    
    CGSize ansSize = CGSizeMake(ceil(textSize.width), ceil(textSize.height));
    return ansSize;
}

- (CGSize)kk_SizeWithFont:(UIFont *)font constrainedToWidth:(CGFloat)width lineBreakMode:(NSLineBreakMode)lineBreakMode
{
    return [self kk_SizeWithFont:font constrainedToSize:CGSizeMake(width, MAXFLOAT) lineBreakMode:lineBreakMode];
}

- (CGSize)kk_SizeWithFont:(UIFont *)font constrainedToSize:(CGSize)size lineBreakMode:(NSLineBreakMode)lineBreakMode lineSpace:(CGFloat)lineSpace;
{
    NSMutableDictionary *attr = [NSMutableDictionary new];
    attr[NSFontAttributeName] = font;
    if (lineBreakMode != NSLineBreakByWordWrapping) {
        NSMutableParagraphStyle *paragraphStyle = [NSMutableParagraphStyle new];
        paragraphStyle.lineBreakMode = lineBreakMode;
        attr[NSParagraphStyleAttributeName] = paragraphStyle;
    }
    else {
        NSMutableParagraphStyle *paragraphStyle = [NSMutableParagraphStyle new];
        paragraphStyle.lineSpacing = lineSpace;
        attr[NSParagraphStyleAttributeName] = paragraphStyle;
    }
    CGRect rect = [self boundingRectWithSize:size
                                     options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading
                                  attributes:attr context:nil];
    return rect.size;
}

@end
