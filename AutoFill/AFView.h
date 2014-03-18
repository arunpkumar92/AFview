//
//  AFTextView.h
//  AutoFill
//
//  Created by Arun Kumar.P on 17/03/14.
//  Copyright (c) 2014 Dev. All rights reserved.
//

#import <UIKit/UIKit.h>

@class AFView;

@protocol AFViewDelegate <NSObject>

@optional

- (void)start;
- (void)endWithSelectedItem:(id)item;

@end

@protocol AFViewDataSource<NSObject>

@optional

- (NSString *)bgImageName;
- (NSString *)emptyMessage;

@required
- (NSArray *)dataSourceArray;
- (UITableViewCell *)afView:(AFView *)afView cellForRowOfItem:(id)item;
- (NSPredicate *)filterPredicateForAFView:(AFView *)afView withSearchString:(NSString *) searchString;
- (CGFloat)afView:(AFView *)afView heightForRowOfItem:(id)item;
@end

@interface AFView : UIView <UITextFieldDelegate, UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, assign) id<AFViewDelegate> delegate;
@property (nonatomic, assign) id <AFViewDataSource> dataSource;

@end
