//
//  AFViewController.h
//  AutoFill
//
//  Created by Arun Kumar.P on 17/03/14.
//  Copyright (c) 2014 Dev. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AFView.h"

@interface AFViewController : UIViewController <AFViewDelegate,AFViewDataSource>

@property (nonatomic, strong) AFView *afView;
@property (nonatomic, strong) UIView *headerView;

@end
