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
#import "TestDragView.h"
#import <QuartzCore/QuartzCore.h>
#import "GANTracker.h"

@implementation ViewController
@synthesize myButton = _myButton;
@synthesize nordjylland = _nordjylland;
@synthesize vestjylland = _ostjylland;

@synthesize touchPoint = _touchPoint;
@synthesize testDrag = _testDrag;

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

//+(ViewController*) init {
//    [super init];
//    NSLog(@"custom init");
//    return [ViewController sharedInstance];
//}

- (void)viewDidLoad
{
        
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    [[GANTracker sharedTracker] trackPageview:@"/menu_view" withError:nil];
    
    
    UIView *borderView = [[UIView alloc] initWithFrame:CGRectMake( (int) self.view.frame.origin.x + 30.0,(int) self.view.frame.origin.y + 35.0,(int) self.view.frame.size.width - 60.0,(int) self.view.frame.size.height - 130.0)];
    borderView.layer.cornerRadius = 1.5;
    borderView.layer.borderWidth = 3.5;
    borderView.layer.borderColor = [UIColor colorWithRed:0 green:0.23 blue:0.42 alpha:1].CGColor;
    borderView.backgroundColor = [UIColor colorWithRed:0.91 green:0.91 blue:0.91 alpha:1];
    
    borderView.layer.shadowOffset = CGSizeMake(0, 0.8);
    borderView.layer.shadowColor = [UIColor grayColor].CGColor;
    borderView.layer.shadowOpacity = 3;
//    borderView.layer.shouldRasterize = YES;
    borderView.frame = CGRectIntegral(borderView.frame);
    
    [self.view addSubview:borderView];
    
    self.nordjylland = [[UILabel alloc] initWithFrame:CGRectMake(30, 45, 200, 46)];
    [self.nordjylland setBackgroundColor:[UIColor clearColor]];
    self.nordjylland.text = @"Nordjylland";
    [self.nordjylland setTextAlignment:NSTextAlignmentCenter];
    [self.nordjylland setFrame:CGRectIntegral(self.nordjylland.frame)];
    self.nordjylland.tag = 20;
    self.nordjylland.textColor = [UIColor colorWithRed:0 green:0.23 blue:0.42 alpha:1];
    [self.nordjylland setFont:[UIFont systemFontOfSize:38]];
    self.nordjylland.opaque = YES;
    [borderView addSubview:self.nordjylland];
    
    UIButton *test = [UIButton buttonWithType:UIButtonTypeCustom];
    test.frame = CGRectMake(10, 200.f, 150.f, 56.f);
    [test setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [test setTitle:@"TEEEST" forState:UIControlStateNormal];
    [test.titleLabel setFont:[UIFont fontWithName:@"Raleway" size:38]];
    [borderView addSubview:test];
    
    self.vestjylland = [[UILabel alloc] initWithFrame:CGRectMake(30, 100, 200, 46)];
    [self.vestjylland setBackgroundColor:[UIColor clearColor]];
    self.vestjylland.text = @"Vestjylland";
    self.vestjylland.tag = 20;
    self.vestjylland.textColor = [UIColor colorWithRed:0 green:0.23 blue:0.42 alpha:1];
    [self.vestjylland setFont:[UIFont fontWithName:@"Raleway" size:38]];
    //self.vestjylland.opaque = YES;
    [borderView addSubview:self.vestjylland];

    self.testDrag = [[TestDragView alloc] initWithFrame:CGRectMake(0, self.view.frame.size.height/2, 320.0, 50.0)];
    self.testDrag.parentView = self.view;
    [self.view addSubview:self.testDrag];
    
}


-(void)moveNextView
{
    MapViewController *mapvViewController = [[MapViewController alloc] init];
    [self.navigationController pushViewController:mapvViewController animated:YES];
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    
    // Get the specific point that was touched
    CGPoint point = [touch locationInView:self.view];
    NSLog(@"Y Location: %f",point.y);
    self.touchPoint = point.y;

    if (point.y > 100 && point.y < 140) {
     
        [self.testDrag repositionWith:point.y];

    }
    
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
