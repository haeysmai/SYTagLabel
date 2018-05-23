//
//  SYTagView.m
//  SYTagLabel
//
//  Created by apple on 2018/5/22.
//  Copyright © 2018年 Haeysmai. All rights reserved.
//

#import "SYTagView.h"

#import "SYTagModel.h"
#import "UILabel+DisplayStatus.h"

static CGFloat marginWidthSpace = 15.f;//text与label左右的间距
static CGFloat labelHeightSpace = 12.f;//两个label上下的间距
static CGFloat labelSpace = 10.f;//两个label左右的间距
static CGFloat topMarginSpace = 15.f;//(上下的间距)第一行和最后一行tag离父试图的高度
static CGFloat tagViewItemHeight = 25.f;//tag的高度
static CGFloat tagMasLeftWidth = 15.f;//每行第一个tag离父试图的宽度

@interface SYTagView()<UIGestureRecognizerDelegate>

@property (nonatomic, strong) NSArray *tagArray;
@property (nonatomic, strong) UILabel *tagLabel;

@end

@implementation SYTagView

+ (instancetype)syTagViewWithFrame:(CGRect)frame tags:(NSArray *)tags {
    return [[self alloc] initWithFrame:frame tags:tags];
}

- (instancetype)initWithFrame:(CGRect)frame tags:(NSArray *)tags {
    self = [super initWithFrame:frame];
    if (self) {
        _tagArray = [tags copy];
        __weak typeof(self) weakSelf = self;
        [_tagArray enumerateObjectsUsingBlock:^(SYTagModel * tagModel, NSUInteger idx, BOOL * _Nonnull stop) {
            weakSelf.tagLabel = [[UILabel alloc] init];
            weakSelf.tagLabel.text = tagModel.tagName;
            weakSelf.tagLabel.tagId = tagModel.tagId;
            weakSelf.tagLabel.layer.cornerRadius = 12.5f;
            weakSelf.tagLabel.layer.masksToBounds = YES;
            weakSelf.tagLabel.font = [UIFont systemFontOfSize:15.f];
            weakSelf.tagLabel.displayStatus = @(UILabelDisplayStatusNormal);
            [weakSelf addSubview:weakSelf.tagLabel];
            [weakSelf.tagLabel reloadCustomLabel];
            
            UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didClickTagLabel:)];
            [weakSelf.tagLabel addGestureRecognizer:tap];
        }];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    CGFloat widthTotal = 0;
    CGFloat preWidth = 0;
    int currentLine = 0;
    int currentIndexX = 0;
    for (int i = 0; i < _tagArray.count; i++) {
        UILabel *itemLabel = nil;
        if (![self.subviews[i] isKindOfClass:[UILabel class]]) {
            continue;
        }
        if (![_tagArray[i] isKindOfClass:[SYTagModel class]] || _tagArray[i] == nil) {
            continue;
        }
        
        itemLabel = (UILabel *)self.subviews[i];
        SYTagModel *tagModel = (SYTagModel *)_tagArray[i];
        CGFloat width = [self getterLabelTextWidthWithText:tagModel.tagName font:[UIFont systemFontOfSize:15.f] height:tagViewItemHeight];
        preWidth = width;
        
        if ((widthTotal + labelSpace * (i - 1) + (width + marginWidthSpace * 2)) > self.frame.size.width) {
            currentLine++;
            widthTotal = 0;
            currentIndexX = 0;
        } else {
            if (i != 0) {
                currentIndexX++;
            }
        }
        itemLabel.frame = CGRectMake(widthTotal + labelSpace * currentIndexX, topMarginSpace + (labelHeightSpace + tagViewItemHeight) * currentLine, width + marginWidthSpace * 2, tagViewItemHeight);
        widthTotal += (preWidth + marginWidthSpace * 2);
        
    }
    
    self.frame = CGRectMake(35, self.frame.origin.y, self.frame.size.width, tagMasLeftWidth * 2 + labelHeightSpace * currentLine + tagViewItemHeight * (currentLine + 1));
    self.translatesAutoresizingMaskIntoConstraints = YES;
}

- (void)didClickTagLabel:(UITapGestureRecognizer *)recognizer {
    if ([self.delegate respondsToSelector:@selector(didClickTagViewItem:)]) {
        [self.delegate didClickTagViewItem:recognizer];
    }
}

#pragma mark - Private Methods

//获取labelText宽度
- (CGFloat)getterLabelTextWidthWithText:(NSString *)text font:(UIFont *)font height:(CGFloat)height {
    CGRect rect = [text boundingRectWithSize:CGSizeMake(MAXFLOAT, height) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:font} context:nil];
    return rect.size.width;
}


@end
