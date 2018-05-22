//
//  UILabel+DisplayStatus.h
//  SYTagLabel
//
//  Created by apple on 2018/5/22.
//  Copyright © 2018年 Haeysmai. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_OPTIONS(NSUInteger, UILabelDisplayStatus) {
    UILabelDisplayStatusNormal       = 0,
    UILabelDisplayStatusSelected     = 1 << 0
};

@interface UILabel (DisplayStatus)

@property (nonatomic, copy) NSNumber *displayStatus;
@property (nonatomic, copy) NSNumber *tagId;

- (UILabel *)reloadCustomLabel;

- (BOOL)isSelected;

@end
