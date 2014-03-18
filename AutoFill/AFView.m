//
//  AFTextView.m
//  AutoFill
//
//  Created by Arun Kumar.P on 17/03/14.
//  Copyright (c) 2014 Dev. All rights reserved.
//

#import "AFView.h"

@interface AFView()

@property (nonatomic, strong) UITextField *searchTextField;
@property (nonatomic, strong) NSArray *dataSourceArray;
@property (nonatomic, strong) NSArray *currentDataSource;
@property (nonatomic, strong) UIView *bgView;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSString *textFieldBgName;
@property (nonatomic, strong) NSString *searchText;
@property (nonatomic, strong) UILabel *notFoundLabel;
@property (nonatomic, strong) UIControl *fullScreenControl;
@property (nonatomic, strong) UIView *transperantBg;

@end

@implementation AFView

#pragma mark - init Methods

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.textFieldBgName = @"Ex_Text_Field_Bg";
        self.dataSourceArray = [NSArray array];
        self.currentDataSource = [self.dataSourceArray copy];
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}

#pragma mark - getter Methods

- (NSArray *)dataSourceArray{
    return [self.dataSource dataSourceArray];
}

- (UITextField *)searchTextField{
    if (_searchTextField == nil) {
        _searchTextField = [[UITextField alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
        _searchTextField.backgroundColor = [UIColor clearColor];
        if ([self.dataSource respondsToSelector:@selector(bgImageName)]) {
            self.textFieldBgName = [self.dataSource bgImageName];
        }
        [_searchTextField setBackground:[UIImage imageNamed:self.textFieldBgName]];
        //[_searchTextField setDelegate:self];
        _searchTextField.autocorrectionType = UITextAutocorrectionTypeNo;
        [_searchTextField setContentVerticalAlignment:UIControlContentVerticalAlignmentCenter];
        CGRect paddingLeftRect = CGRectMake(0, 0, 10, 42);
        CGRect paddingRightRect = CGRectMake(0, 0, 30, 42);
        _searchTextField.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        UIView *paddingLeftView = [[UIView alloc] initWithFrame:paddingLeftRect];
        paddingLeftView.userInteractionEnabled = false;
        paddingLeftView.backgroundColor = [UIColor clearColor];
        _searchTextField.leftView = paddingLeftView;
        _searchTextField.leftViewMode = UITextFieldViewModeAlways;
        UIView *paddingRightView = [[UIView alloc] initWithFrame:paddingRightRect];
        paddingRightView.userInteractionEnabled = false;
        paddingRightView.backgroundColor = [UIColor clearColor];
        _searchTextField.rightView = paddingRightView;
        _searchTextField.rightViewMode = UITextFieldViewModeAlways;
        _searchTextField.autocapitalizationType = UITextAutocapitalizationTypeWords;
        _searchTextField.delegate = self;
    }
    return _searchTextField;
}

- (UITableView *)tableView{
    if (_tableView == nil) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(100, 100, self.frame.size.width, (5*self.frame.size.height))];
        _tableView.delegate = self;
        _tableView.dataSource = self;
    }
    return _tableView;
}

- (UILabel *)notFoundLabel{
    if (_notFoundLabel == nil) {
        _notFoundLabel = [[UILabel alloc] init];
        _notFoundLabel.frame = CGRectMake(25, 23, 225, 18);
        
        _notFoundLabel.text = @"Not found";
        _notFoundLabel.textAlignment = NSTextAlignmentLeft;
        _notFoundLabel.backgroundColor = [UIColor clearColor];
        _notFoundLabel.textColor = [UIColor grayColor];
    }
    if ([self.dataSource respondsToSelector:@selector(emptyMessage)]) {
        _notFoundLabel.text = [self.dataSource emptyMessage];
    }
    return _notFoundLabel;
}

- (UIControl *)fullScreenControl{
    if (_fullScreenControl == nil) {
        _fullScreenControl = [[UIControl alloc] initWithFrame:CGRectMake(0, 0, [[UIScreen mainScreen] applicationFrame].size.width, [[UIScreen mainScreen] applicationFrame].size.height)];
        _fullScreenControl.backgroundColor = [UIColor clearColor];
        _fullScreenControl.hidden = false;
        [_fullScreenControl addTarget:self action:@selector(outsideClick:) forControlEvents:UIControlEventTouchUpInside];
        [_fullScreenControl addSubview:self.transperantBg];
        _fullScreenControl.autoresizesSubviews = YES;
    }
    return _fullScreenControl;
}

- (UIView *)transperantBg{
    if (_transperantBg == nil) {
        _transperantBg = [[UIView alloc] initWithFrame:CGRectMake(0, 0, [[UIScreen mainScreen] applicationFrame].size.width, [[UIScreen mainScreen] applicationFrame].size.height)];
        _transperantBg.backgroundColor = [UIColor clearColor];
        [_transperantBg setBackgroundColor:[UIColor yellowColor]];
        _transperantBg.alpha = 0.7;
        _transperantBg.userInteractionEnabled = false;
        _transperantBg.autoresizesSubviews = YES;
    }
    return _transperantBg;
    
}

#pragma mark - custom Methods

- (void)close:(id)item{
    
    if ([self.delegate respondsToSelector:@selector(endWithSelectedItem:)]){
        [self.delegate endWithSelectedItem:item];
    }
    [self.fullScreenControl removeFromSuperview];
    [self.searchTextField resignFirstResponder];
    [self.searchTextField removeFromSuperview];
    [self addSubview:self.searchTextField];
    self.searchTextField.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
}

- (void)open{
    if ([self.delegate respondsToSelector:@selector(start)]){
        [self.delegate start];
    }
    
    UIViewController *currentViewController = [UIApplication sharedApplication].keyWindow.rootViewController;
    currentViewController.view.backgroundColor = [UIColor blueColor];
    // Add the subview to the main window
    [currentViewController.view addSubview:self.fullScreenControl];
    
    [self.searchTextField removeFromSuperview];
    CGPoint point = [self convertPoint:self.searchTextField.frame.origin toView:self.fullScreenControl];
    [self.fullScreenControl addSubview:self.searchTextField];
    self.searchTextField.frame = CGRectMake(point.x, point.y, self.frame.size.width, self.frame.size.height);
    self.tableView.frame = CGRectMake(point.x, (point.y+self.frame.size.height), self.frame.size.width, (self.frame.size.height*5));
    // Release the subview
    
    
}

- (void)reloadList{
    
    if (self.searchText.length > 0) {
        NSPredicate *searchPredicate = [self.dataSource filterPredicateForAFView:self withSearchString:self.searchText];
        self.currentDataSource = [self.dataSourceArray filteredArrayUsingPredicate:searchPredicate];
    }else{
        self.currentDataSource = self.dataSourceArray;
    }

    [self.tableView reloadData];
}

#pragma mark - Actions

- (void)outsideClick:(id)sender{
    [self close:nil];
}

#pragma mark - draw Methods


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
    [self reloadList];
    [self addSubview:self.searchTextField];
    [self.fullScreenControl addSubview:self.tableView];
}


#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [self.currentDataSource count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
     return [self.dataSource afView:self cellForRowOfItem:[self.currentDataSource objectAtIndex:indexPath.row]];
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString *name = [self.currentDataSource objectAtIndex:indexPath.row];
    self.searchText = name;
    self.searchTextField.text = name;
    [self close:name];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return [self.dataSource afView:self heightForRowOfItem:[self.currentDataSource objectAtIndex:indexPath.row]];
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (self.currentDataSource.count > 0) {
        return 0;
    }else{
        return 18;
    }
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *view = nil;
    if (self.currentDataSource.count <= 0) {
        view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.frame.size.width, 18)];
        [view addSubview:self.notFoundLabel];
        [view setBackgroundColor:[UIColor clearColor]]; //your background color...
    }
    return view;
    
}

#pragma mark UITextFieldDelegate methods

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    //_field.background = [UIImage imageNamed:@"focus.png"];
    self.searchText = @"";
    [self open];
    return YES;
}

- (BOOL)textFieldShouldEndEditing:(UITextField *)textField
{
    //_field.background = [UIImage imageNamed:@"nofocus.png"];
    [self close:[self.currentDataSource lastObject]];
    return YES;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

- (void)textFieldDidEndEditing:(UITextField *)textField{
    self.searchText = textField.text;
    [self reloadList];
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    
    self.searchText = [textField.text stringByReplacingCharactersInRange:range withString:string];
    [self reloadList];
    return YES;
    
    // return NO to not change text // may be after validation
}

@end
