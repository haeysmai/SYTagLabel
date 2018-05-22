//
//  ViewController.m
//  SYTagLabel
//
//  Created by apple on 2018/5/22.
//  Copyright © 2018年 Haeysmai. All rights reserved.
//

#import "ViewController.h"

#import "UILabel+DisplayStatus.h"
#import "SYTagView.h"
#import "TagModel.h"

@interface ViewController () <SYTagViewDelegate>

@property (nonatomic, strong) SYTagView *syTagView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _syTagView = [SYTagView syTagViewWithFrame:CGRectMake(35.f, 100, CGRectGetWidth(self.view.frame) - 70.f, 400) tags:[self loadTags]];
    _syTagView.backgroundColor = [UIColor clearColor];
    _syTagView.delegate = self;
    [self.view addSubview:_syTagView];
}

#pragma mark - SYTagViewDelegate

- (void)didClickTagViewItem:(UITapGestureRecognizer *)recognizer {
    if (![recognizer.self.view isKindOfClass:[UILabel class]]) {
        return;
    }
    UILabel *clickTagLabel = (UILabel *)recognizer.self.view;
    
    if ([clickTagLabel isSelected]) {
        clickTagLabel.displayStatus = @(UILabelDisplayStatusNormal);
        [clickTagLabel reloadCustomLabel];
        return;
    }
    
    for (int i = 0; i < recognizer.self.view.superview.subviews.count; i++) {
        if (![recognizer.self.view.superview.subviews[i] isKindOfClass:[UILabel class]]) {
            continue;
        }
        UILabel *tagLabel = (UILabel *)recognizer.self.view.superview.subviews[i];
        if ([clickTagLabel.text isEqualToString:tagLabel.text]) {
            clickTagLabel.displayStatus = @(UILabelDisplayStatusSelected);
        } else {
            tagLabel.displayStatus = @(UILabelDisplayStatusNormal);
        }
        [tagLabel reloadCustomLabel];
        [clickTagLabel reloadCustomLabel];
    }
}

#pragma mark - DataSource

- (NSArray *)loadTags {
    NSArray *tagNames = @[@"objective-C", @"Python", @"Swift", @"C", @"C++", @"Java", @"JavaScript", @"Go", @"TypeScript",@"PHP",@"Ruby",@"Erlang"];
    
    NSMutableArray *array = [NSMutableArray array];
    for (int i = 0; i < tagNames.count; i++) {
        TagModel *tagModel = [[TagModel alloc] init];
        tagModel.tagName = tagNames[i];
        tagModel.tagId = @(i + 1);
        [array addObject:tagModel];
    }
    return [array copy];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
