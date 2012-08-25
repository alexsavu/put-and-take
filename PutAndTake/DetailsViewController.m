//
//  DetailsViewController.m
//  PutAndTake
//
//  Created by Alexandru Savu on 7/29/12.
//
//

#import "DetailsViewController.h"
#import <QuartzCore/QuartzCore.h>

@interface DetailsViewController ()

@end

@implementation DetailsViewController

@synthesize cellView = _cellView;
@synthesize doneButton = _doneButton;

- (id)initWithSize:(double )x Y:(double)y Width:(double)width Height:(double)height
{
    self = [super init];
    if (self) {
        self.view.frame = CGRectMake(x, y, width, height);
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    [self.navigationController setNavigationBarHidden:NO];
    
    self.view.frame = CGRectMake(0 , 0, 320, 200);
    
    CGRect fullScreen = [[UIScreen mainScreen] applicationFrame];
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:fullScreen];
    scrollView.contentSize = CGSizeMake(320.0, 750.0);
    
    self.cellView = [[UIView alloc] initWithFrame:CGRectMake((self.view.frame.size.width - 280)-(self.view.frame.size.width - 280)/2, 70.0, 280.0, 220.0)];
    
    self.cellView.layer.cornerRadius = 6.0;
    self.cellView.layer.borderWidth = 0.3;
    self.cellView.layer.shadowOffset = CGSizeMake(0, 0.8);
    self.cellView.layer.shadowColor = [UIColor grayColor].CGColor;
    self.cellView.layer.shadowOpacity = 3;
    self.cellView.layer.shouldRasterize = YES;
    self.cellView.backgroundColor = [UIColor colorWithRed:0.91 green:0.91 blue:0.91 alpha:1];
    self.view = scrollView;
    [self.view addSubview:self.cellView];
    
    UIButton *doneButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
//    doneButton.layer.cornerRadius = 3.0;
//    doneButton.layer.borderWidth = 0.3;
    [doneButton setTitle:@"done" forState:UIControlStateNormal];
//    [doneButton setTitleColor:[UIColor colorWithRed:0 green:0.23 blue:0.42 alpha:1] forState:UIControlStateNormal];
    doneButton.frame = CGRectMake(250.0, 10.0, 60.0, 40.0);
//    doneButton.titleLabel.font = [UIFont fontWithName:@"Raleway" size:15];
    [doneButton addTarget:self action:@selector(close:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:doneButton];
    
    self.view.backgroundColor = [UIColor colorWithRed:0.88 green:0.88 blue:0.88 alpha:1];
}

- (void)close:(id)sender
{
    NSLog(@"View dismissed");
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
