//
//  AFViewController.m
//  AutoFill
//
//  Created by Arun Kumar.P on 17/03/14.
//  Copyright (c) 2014 Dev. All rights reserved.
//

#import "AFViewController.h"
#import "AFDropDownCell.h"

@interface AFViewController ()

@end

@implementation AFViewController

#pragma mark - init Method

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

#pragma mark - getter methods

- (AFView *)afView {
    if (_afView == nil) {
        _afView = [[AFView alloc] initWithFrame:CGRectMake(45, 45, 231, 42)];
        _afView.delegate = self;
        _afView.dataSource = self;
        [_afView setBackGroundImage:[UIImage imageNamed:@"Ex_Text_Field_Bg"]];
        //[_searchTextField setDelegate:self];
        _afView.searchTextField.autocorrectionType = UITextAutocorrectionTypeNo;
        [_afView.searchTextField setContentVerticalAlignment:UIControlContentVerticalAlignmentCenter];
        CGRect paddingLeftRect = CGRectMake(0, 0, 10, 42);
        CGRect paddingRightRect = CGRectMake(0, 0, 30, 42);
        _afView.searchTextField.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        UIView *paddingLeftView = [[UIView alloc] initWithFrame:paddingLeftRect];
        paddingLeftView.userInteractionEnabled = false;
        paddingLeftView.backgroundColor = [UIColor clearColor];
        _afView.searchTextField.leftView = paddingLeftView;
        _afView.searchTextField.leftViewMode = UITextFieldViewModeAlways;
        UIView *paddingRightView = [[UIView alloc] initWithFrame:paddingRightRect];
        paddingRightView.userInteractionEnabled = false;
        paddingRightView.backgroundColor = [UIColor clearColor];
        _afView.searchTextField.rightView = paddingRightView;
        _afView.searchTextField.rightViewMode = UITextFieldViewModeAlways;
    }
    return _afView;
}

- (UIView *)headerView {
    if (_headerView == nil) {
        _headerView = [[UIView alloc] initWithFrame:CGRectMake(300, 300, 431, 100)];
        _headerView.backgroundColor = [UIColor redColor];
    }
    return _headerView;
}

#pragma mark - View Functions

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.view addSubview:self.headerView];
    [self.headerView addSubview:self.afView];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -  AFViewDelegate

- (void)start{
    
}

- (void)endWithSelectedItem:(id)item{
    NSString *name = (NSString *)item;
    NSLog(@"SelectedItem = %@",name);
}

#pragma mark -  AFViewDataSource

- (NSArray *)dataSourceArray{
    return [NSArray arrayWithObjects:@"Hafees",
            @"Arun",
            @"Suneeth",
            @"siju",
            @"sebi",
            @"tom",
            @"Parveen",
            @"kiran",
            @"shihab",
            @"sreehari",
            @"sunil",
            @"arun K R",
            @"saif",
            @"pra", nil];
}

- (UITableViewCell *)afView:(AFView *)afView cellForRowOfItem:(id)item{
    
    AFDropDownCell *cell = [[AFDropDownCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
    UIView *selectedBackgroundView = [[UIView alloc] init];
    cell.selectedBackgroundView = selectedBackgroundView;
    cell.selectedBackgroundView.backgroundColor = [UIColor greenColor];
    NSString *name = (NSString *)item;
    cell.contentLabel.text = name;
    return cell;
    
}

- (NSPredicate *)filterPredicateForAFView:(AFView *)afView withSearchString:(NSString *) searchString{
    return [NSPredicate predicateWithFormat:@"self  CONTAINS[c] %@", searchString];
}

- (CGFloat)afView:(AFView *)afView heightForRowOfItem:(id)item{
    CGFloat heightForCell = 0.0f;
    NSString *name = (NSString *)item;
    heightForCell = [AFDropDownCell heightForCellForText:name];
    return heightForCell;
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
 {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
