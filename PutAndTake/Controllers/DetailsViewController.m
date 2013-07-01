//
//  DetailsViewController.m
//  PutAndTake
//
//  Created by Alexandru Savu on 7/29/12.
//
//

#import "DetailsViewController.h"
#import <QuartzCore/QuartzCore.h>
#import "ServerData.h"
#import "UIViewController+KNSemiModal.h"

#define font_size 15.0
#define label_position_X 40.0
#define label_height 20.0
#define label_width 220.0

@interface DetailsViewController ()

@property (nonatomic, strong) NSArray *iconSearchArray;

@end

@implementation DetailsViewController

@synthesize cellView = _cellView;
@synthesize doneButton = _doneButton;
@synthesize sharedLocations = _sharedLocations;

@synthesize price = _price;
@synthesize phone = _phone;
@synthesize address = _address;

- (id)initWithSize:(double )x Y:(double)y Width:(double)width Height:(double)height{
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
    
    [self performSelector:@selector(getServerData) withObject:self afterDelay:0.2];
    [self.navigationController setNavigationBarHidden:NO];
    self.view.frame = CGRectMake(0 , 0, 320, 200);
    
    self.cellView = [[UIView alloc] initWithFrame:CGRectMake((self.view.frame.size.width - 280)-(self.view.frame.size.width - 280)/2, 70.0, 280.0, 220.0)];
    
    self.cellView.layer.cornerRadius = 6.0;
    self.cellView.layer.borderWidth = 3.5;
    self.cellView.layer.borderColor = [UIColor colorWithRed:0 green:0.23 blue:0.42 alpha:1].CGColor;
    self.cellView.backgroundColor = [UIColor colorWithRed:0.91 green:0.91 blue:0.91 alpha:1];
    [self.view addSubview:self.cellView];
    
    self.doneButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.doneButton.layer.cornerRadius = 3.0;
    self.doneButton.layer.borderWidth = 0.3;
    [self.doneButton setTitle:@"done" forState:UIControlStateNormal];
    [self.doneButton setTitleColor:[UIColor colorWithRed:0 green:0.23 blue:0.42 alpha:1] forState:UIControlStateNormal];
    self.doneButton.frame = CGRectMake(250.0, 10.0, 60.0, 40.0);
    self.doneButton.titleLabel.font = [UIFont fontWithName:@"Raleway" size:15];
    [self.doneButton addTarget:self action:@selector(close:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.doneButton];
    
    self.view.backgroundColor = [UIColor colorWithRed:0.88 green:0.88 blue:0.88 alpha:1];
}

-(void)getServerData
{
    ServerData *data = [[ServerData alloc] init];
    self.sharedLocations = data.locations;
    
    UILabel *priceLabel = [[UILabel alloc] initWithFrame:CGRectMake(40.0, self.cellView.frame.size.height/4 - label_height, label_width, label_height)];
    [priceLabel setBackgroundColor:[UIColor clearColor]];
    priceLabel.textColor = [UIColor blackColor];
    [priceLabel setFont:[UIFont fontWithName:@"Raleway" size:font_size]];
    priceLabel.text = [NSString stringWithFormat:@"%@ kr",self.price];
    [self.cellView addSubview:priceLabel];
    
    UIImageView *priceImage = [[UIImageView alloc] initWithFrame:CGRectMake(8.0, self.cellView.frame.size.height/4 - label_height, 20.f, label_height)];
    [priceImage setImage:[UIImage imageNamed:@"euro.png"]];
    [self.cellView addSubview:priceImage];
    
    UILabel *phoneLabel = [[UILabel alloc] initWithFrame:CGRectMake(40.0, self.cellView.frame.size.height/4*2 - label_height, label_width, label_height)];
    [phoneLabel setBackgroundColor:[UIColor clearColor]];
    phoneLabel.textColor = [UIColor blackColor];
    [phoneLabel setFont:[UIFont fontWithName:@"Raleway" size:font_size]];
    phoneLabel.text = [NSString stringWithFormat:@"%@",self.phone];
    [self.cellView addSubview:phoneLabel];
    
    UIImageView *phoneImage = [[UIImageView alloc] initWithFrame:CGRectMake(8.0, self.cellView.frame.size.height/4*2 - label_height, 20.f, label_height + 6)];
    [phoneImage setImage:[UIImage imageNamed:@"phone.png"]];
    [self.cellView addSubview:phoneImage];
    
    UILabel *addressLabel = [[UILabel alloc] initWithFrame:CGRectMake(40.0, self.cellView.frame.size.height/4*3 - label_height, label_width, label_height * 2)];
    [addressLabel setBackgroundColor:[UIColor clearColor]];
    addressLabel.textColor = [UIColor blackColor];
    [addressLabel setLineBreakMode:NSLineBreakByWordWrapping];
    addressLabel.numberOfLines = 0;
    [addressLabel setFont:[UIFont fontWithName:@"Raleway" size:font_size]];
    addressLabel.text = [NSString stringWithFormat:@"%@",self.address];
    [self.cellView addSubview:addressLabel];
    
    UIImageView *addressImage = [[UIImageView alloc] initWithFrame:CGRectMake(8.0, self.cellView.frame.size.height/4*3 - label_height, 20.f, label_height)];
    [addressImage setImage:[UIImage imageNamed:@"home.png"]];
    [self.cellView addSubview:addressImage];
    
}

- (void)close:(id)sender
{ 
    [self dismissSemiModalView];
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
