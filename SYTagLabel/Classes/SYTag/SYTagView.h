//
//  SYTagView.h
//  SYTagLabel
//
//  Created by apple on 2018/5/22.
//  Copyright © 2018年 Haeysmai. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol SYTagViewDelegate<NSObject>

@optional
- (void)didClickTagViewItem:(UITapGestureRecognizer *)recognizer;

@end

@interface SYTagView : UIView

@property (nonatomic, weak) id<SYTagViewDelegate> delegate;

+ (instancetype)syTagViewWithFrame:(CGRect)frame tags:(NSArray *)tags;

@end
