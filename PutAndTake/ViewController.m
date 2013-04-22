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

@interface ViewController()

@property (nonatomic, retain) CAShapeLayer *pathLayer;
@property (nonatomic, retain) CALayer *animationLayer;

@end

@implementation ViewController
@synthesize pathLayer = _pathLayer;
@synthesize animationLayer = _animationLayer;

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

- (void)viewDidLoad{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    [[GANTracker sharedTracker] trackPageview:@"/menu_view" withError:nil];
    
    UIView *borderView = [[UIView alloc] initWithFrame:CGRectMake( (int) self.view.frame.origin.x + 25.0,(int) self.view.frame.origin.y + 35.0,(int) self.view.frame.size.width - 50.0,(int) self.view.frame.size.height - 130.0)];
    borderView.layer.cornerRadius = 1.5;
    borderView.layer.borderWidth = 3.5;
    borderView.layer.borderColor = [UIColor colorWithRed:0 green:0.23 blue:0.42 alpha:1].CGColor;
    borderView.backgroundColor = [UIColor colorWithRed:0.91 green:0.91 blue:0.91 alpha:1];
    
    self.animationLayer = [CALayer layer];
    self.animationLayer.frame = CGRectMake(20.0f, 64.0f,
                                           CGRectGetWidth(borderView.layer.bounds) ,
                                           CGRectGetHeight(borderView.layer.bounds));
    [borderView.layer addSublayer:self.animationLayer];
    
//    [self setupDrawingLayer];
//    [self startAnimation];
    
//    borderView.layer.shadowOffset = CGSizeMake(0, 0.8);
//    borderView.layer.shadowColor = [UIColor grayColor].CGColor;
//    borderView.layer.shadowOpacity = 3;
    
    [self.view addSubview:borderView];
    
    NSLog(@"Borderview size: %f", borderView.frame.size.width);
    
    self.nordjylland = [[UILabel alloc] initWithFrame:CGRectMake(15, 46, 200, 46)];
    [self.nordjylland setBackgroundColor:[UIColor clearColor]];
    self.nordjylland.text = @"Nordjylland";
    [self.nordjylland setTextAlignment:NSTextAlignmentCenter];
    [self.nordjylland setFrame:CGRectIntegral(self.nordjylland.frame)];
    self.nordjylland.tag = 20;
    self.nordjylland.textColor = [UIColor colorWithRed:0 green:0.23 blue:0.42 alpha:1];
    [self.nordjylland setFont:[UIFont fontWithName:@"Raleway" size:38]];
    self.nordjylland.opaque = YES;
    [borderView addSubview:self.nordjylland];
    
    self.vestjylland = [[UILabel alloc] initWithFrame:CGRectMake(15, 101, 200, 46)];
    [self.vestjylland setBackgroundColor:[UIColor clearColor]];
    self.vestjylland.text = @"Vestjylland";
    self.vestjylland.tag = 20;
    self.vestjylland.textColor = [UIColor colorWithRed:0 green:0.23 blue:0.42 alpha:1];
    [self.vestjylland setFont:[UIFont fontWithName:@"Raleway" size:38]];
    //self.vestjylland.opaque = YES;
    [borderView addSubview:self.vestjylland];
    
    self.sonderjylland = [[UILabel alloc] initWithFrame:CGRectMake(15, 156, 240, 46)];
    [self.sonderjylland setBackgroundColor:[UIColor clearColor]];
    self.sonderjylland.text = @"Sønderjylland";
    self.sonderjylland.tag = 20;
    self.sonderjylland.textColor = [UIColor colorWithRed:0 green:0.23 blue:0.42 alpha:1];
    [self.sonderjylland setFont:[UIFont fontWithName:@"Raleway" size:38]];
    //self.vestjylland.opaque = YES;
    [borderView addSubview:self.sonderjylland];

    self.testDrag = [[TestDragView alloc] initWithFrame:CGRectMake(0, self.view.frame.size.height/2, 320.0, 50.0)];
    self.testDrag.parentView = self.view;
    [self.view addSubview:self.testDrag];
    
}

#pragma mark Animation

- (void) setupDrawingLayer
{
    if (self.pathLayer != nil) {
        [self.pathLayer removeFromSuperlayer];
        self.pathLayer = nil;
    }
    
    CGRect pathRect = CGRectInset(self.animationLayer.bounds, 100.0f, 100.0f);
    CGPoint bottomLeft 	= CGPointMake(CGRectGetMinX(pathRect), CGRectGetMinY(pathRect));
    CGPoint topLeft		= CGPointMake(CGRectGetMinX(pathRect), CGRectGetMinY(pathRect) + CGRectGetHeight(pathRect) * 2.0f/3.0f);
    CGPoint bottomRight = CGPointMake(CGRectGetMaxX(pathRect), CGRectGetMinY(pathRect));
    CGPoint topRight	= CGPointMake(CGRectGetMaxX(pathRect), CGRectGetMinY(pathRect) + CGRectGetHeight(pathRect) * 2.0f/3.0f);
    CGPoint roofTip		= CGPointMake(CGRectGetMidX(pathRect), CGRectGetMaxY(pathRect));
    
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path moveToPoint:bottomLeft];
    [path addLineToPoint:topLeft];
    [path addLineToPoint:roofTip];
    [path addLineToPoint:topRight];
    [path addLineToPoint:topLeft];
    [path addLineToPoint:bottomRight];
    [path addLineToPoint:topRight];
    [path addLineToPoint:bottomLeft];
    [path addLineToPoint:bottomRight];
    
    CAShapeLayer *pathLayer = [CAShapeLayer layer];
    pathLayer.frame = self.animationLayer.bounds;
    pathLayer.bounds = pathRect;
    pathLayer.geometryFlipped = YES;
    pathLayer.path = path.CGPath;
    pathLayer.strokeColor = [[UIColor blackColor] CGColor];
    pathLayer.fillColor = nil;
    pathLayer.lineWidth = 10.0f;
    pathLayer.lineJoin = kCALineJoinBevel;
    
    [self.animationLayer addSublayer:pathLayer];
    
    self.pathLayer = pathLayer;
}

- (void) startAnimation{
    [self.pathLayer removeAllAnimations];
    CABasicAnimation *pathAnimation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    pathAnimation.duration = 10.0;
    pathAnimation.fromValue = [NSNumber numberWithFloat:0.0f];
    pathAnimation.toValue = [NSNumber numberWithFloat:1.0f];
    [self.pathLayer addAnimation:pathAnimation forKey:@"strokeEnd"];
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
