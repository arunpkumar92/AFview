AFview
======

Auto fill text field (combo box for ios)

This is a view for you to either use as-is or modify the source. The view comes loaded with the ability to:

Create a self contained view replicating the look and feel of combobox in a web page

Implementation:

The view is a subclass of a UIControl It contains textfield, table view, background Image name  and foreground blur view. 
and it have two protocols like UItable view are datasource and delegate.
Data source used for passing the data source array , view can pass custom UITableViewCell , row height 
and a option to add custom NSPredicate for serching.

Delegate give the selected item , and click event like open and close.

How to use (Simple Version):

Import AFView.h

Create an instance of AFView - 

@property (nonatomic, strong) AFView *afView;

- (AFView *)afView {
    if (_afView == nil) {
        _afView = [[AFView alloc] initWithFrame:CGRectMake(45, 45, 231, 42)];
        _afView.delegate = self;
        _afView.dataSource = self;
    }
    return _afView;
}

Add AFView to your destination view 

[yourView addSubview:self.afView];

Confirm delgate and data source in your header file

@interface AFViewController : UIViewController <AFViewDelegate,AFViewDataSource>

Implement the data source and Delegats

#pragma mark -  AFViewDelegate 

- (void)start{
 // start searching
}

- (void)endWithSelectedItem:(id)item{  // get selected item
    NSString *name = (NSString *)item;
    NSLog(@"SelectedItem = %@",name);
}

#pragma mark -  AFViewDataSource

- (NSArray *)dataSourceArray{
    return your list array
}

- (UITableViewCell *)afView:(AFView *)afView cellForRowOfItem:(id)item{  // cell
    
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

@optional

- (NSString *)bgImageName{
    return @"Ex_Text_Field_Bg";
}

- (NSString *)emptyMessage{
    return @"coustom Not found";
}


