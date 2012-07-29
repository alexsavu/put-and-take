//
//  ViewController.m
//  PutAndTake
//
//  Created by Alexandru Savu on 6/11/12Week24.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ViewController.h"
#import "ServerData.h"
#import "MapViewController.h"

@interface ViewController () <MapViewDelegate>

@property (nonatomic, weak) MapViewController *mapViewController;

@end

@implementation ViewController
@synthesize myButton = _myButton;

static NSInteger _pressedTag = 0;

static ViewController *singleton = nil;
+(ViewController *) sharedInstance
{
    if (singleton == nil) {
        singleton = [[ViewController alloc] init];
    }
    return singleton;
}

+(NSInteger) pressedTag {
    return _pressedTag;
}

+(void) setPressedTag:(NSInteger) pressedTag {
    _pressedTag = pressedTag;
}

-(void) addButton
{
    self.myButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    self.myButton.frame = CGRectMake(110.0, 360.0, 100.0, 30.0);
    [ViewController setPressedTag:20];
    [self.myButton setTitle:@"Nordjylland" forState:UIControlStateNormal];
    [self.myButton addTarget:self action:@selector(moveNextView) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.myButton];

}


- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.

    self.mapViewController.delegate = self;
    
    
    [self addButton];
    NSLog(@"My button tag is: %i", self.myButton.tag);
}

-(void)setMapViewController:(MapViewController *)mapViewController
{
    _mapViewController = mapViewController;
    self.mapViewController.delegate = self;
}

-(void) moveNextView
{
    MapViewController *mapvViewController = [[MapViewController alloc] init];
    [self.navigationController pushViewController:mapvViewController animated:YES];
}

-(NSInteger) buttonTag:(MapViewController *)sender
{
    return self.myButton.tag;
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}


@end
