//
//  UILabel+DisplayStatus.m
//  SYTagLabel
//
//  Created by apple on 2018/5/22.
//  Copyright © 2018年 Haeysmai. All rights reserved.
//

#import "UILabel+DisplayStatus.h"
#import <objc/runtime.h>

#define random(r, g, b, a) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:(a)/255.0]

#define randomColor random(arc4random_uniform(256), arc4random_uniform(256), arc4random_uniform(256), arc4random_uniform(256))

@implementation UILabel (DisplayStatus)

static char *DisplayStatus = "DisplayStatus";
static char *TagId = "TagId";

- (void)setDisplayStatus:(NSNumber *)displayStatus {
    objc_setAssociatedObject(self, DisplayStatus, displayStatus, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (NSNumber *)displayStatus {
    return objc_getAssociatedObject(self, DisplayStatus);
}

- (void)setTagId:(NSNumber *)tagId {
    objc_setAssociatedObject(self, TagId, tagId, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (NSNumber *)tagId {
    return objc_getAssociatedObject(self, TagId);
}

- (UILabel *)reloadCustomLabel {
    self.userInteractionEnabled = YES;
    self.textAlignment = NSTextAlignmentCenter;
    self.alpha = 0.7f;
    if ([self.displayStatus isEqual:@(UILabelDisplayStatusNormal)]) {
        self.backgroundColor = [UIColor lightGrayColor];
        self.textColor = [UIColor whiteColor];
    } else if ([self.displayStatus isEqual:@(UILabelDisplayStatusSelected)]) {
        self.backgroundColor = randomColor;
        self.textColor = [UIColor whiteColor];
    }
    return self;
}

- (BOOL)isSelected {
    if ([self.displayStatus isEqual:@(UILabelDisplayStatusSelected)]) {
        return YES;
    }
    return NO;
}

@end
