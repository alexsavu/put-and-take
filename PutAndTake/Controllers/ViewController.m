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

@synthesize touchPoint = _touchPoint;
@synthesize testDrag = _testDrag;

- (void)viewDidLoad{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    [[GANTracker sharedTracker] trackPageview:@"/menu_view" withError:nil];
    
    [self layoutLabels];

    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeFontAcordingly:) name:@"AnimationDone" object:nil];
}

-(void)layoutLabels{
    UIView *borderView = [[UIView alloc] initWithFrame:CGRectMake( (int) self.view.frame.origin.x + 25.0,(int) self.view.frame.origin.y + 35.0,(int) self.view.frame.size.width - 50.0,(int) self.view.frame.size.height - 130.0)];
    borderView.layer.cornerRadius = 1.5;
    borderView.layer.borderWidth = 3.5;
    borderView.layer.borderColor = [UIColor colorWithRed:0 green:0.23 blue:0.42 alpha:1].CGColor;
    borderView.backgroundColor = [UIColor colorWithRed:0.91 green:0.91 blue:0.91 alpha:1];
    
    [self.view addSubview:borderView];
    CGRect screenBounds = [[UIScreen mainScreen] bounds];
    if (screenBounds.size.height == 480) {
        // iphone 4,4s screen
        self.nordjylland = [[UILabel alloc] initWithFrame:CGRectMake(15, 30, 200, 46)];
        [self.nordjylland setBackgroundColor:[UIColor clearColor]];
        self.nordjylland.text = @"Nordjylland";
        [self.nordjylland setTextAlignment:NSTextAlignmentCenter];
        [self.nordjylland setFrame:CGRectIntegral(self.nordjylland.frame)];
        self.nordjylland.textColor = [UIColor colorWithRed:0 green:0.23 blue:0.42 alpha:1];
        [self.nordjylland setFont:[UIFont fontWithName:@"Raleway" size:38]];
        [borderView addSubview:self.nordjylland];
        
        self.oestjylland = [[UILabel alloc] initWithFrame:CGRectMake(15, 80, 200, 46)];
        [self.oestjylland setBackgroundColor:[UIColor clearColor]];
        self.oestjylland.text = @"Østjylland";
        self.oestjylland.textColor = [UIColor colorWithRed:0 green:0.23 blue:0.42 alpha:1];
        [self.oestjylland setFont:[UIFont fontWithName:@"Raleway" size:38]];
        [borderView addSubview:self.oestjylland];
        
        self.vestjylland = [[UILabel alloc] initWithFrame:CGRectMake(15, 130, 240, 46)];
        [self.vestjylland setBackgroundColor:[UIColor clearColor]];
        self.vestjylland.text = @"Vestjylland";
        self.vestjylland.textColor = [UIColor colorWithRed:0 green:0.23 blue:0.42 alpha:1];
        [self.vestjylland setFont:[UIFont fontWithName:@"Raleway" size:38]];
        [borderView addSubview:self.vestjylland];
        
        self.sjaelland = [[UILabel alloc] initWithFrame:CGRectMake(15, 180, 240, 46)];
        [self.sjaelland setBackgroundColor:[UIColor clearColor]];
        self.sjaelland.text = @"Sjælland";
        self.sjaelland.textColor = [UIColor colorWithRed:0 green:0.23 blue:0.42 alpha:1];
        [self.sjaelland setFont:[UIFont fontWithName:@"Raleway" size:38]];
        [borderView addSubview:self.sjaelland];
        
        self.sonderjylland = [[UILabel alloc] initWithFrame:CGRectMake(15, 230, 240, 46)];
        [self.sonderjylland setBackgroundColor:[UIColor clearColor]];
        self.sonderjylland.text = @"Sønderjylland";
        self.sonderjylland.textColor = [UIColor colorWithRed:0 green:0.23 blue:0.42 alpha:1];
        [self.sonderjylland setFont:[UIFont fontWithName:@"Raleway" size:38]];
        [borderView addSubview:self.sonderjylland];
        
        self.fyn = [[UILabel alloc] initWithFrame:CGRectMake(15, 280, 240, 46)];
        [self.fyn setBackgroundColor:[UIColor clearColor]];
        self.fyn.text = @"Fyn";
        self.fyn.textColor = [UIColor colorWithRed:0 green:0.23 blue:0.42 alpha:1];
        [self.fyn setFont:[UIFont fontWithName:@"Raleway" size:38]];
        [borderView addSubview:self.fyn];
        
        self.testDrag = [[TestDragView alloc] initWithFrame:CGRectMake(0, self.view.frame.size.height/2, 320.0, 50.0)];
        self.testDrag.parentView = self.view;;
        [self.view addSubview:self.testDrag];
    }else if (screenBounds.size.height == 568){
        //iphone 5 sceen
        self.nordjylland = [[UILabel alloc] initWithFrame:CGRectMake(15, 48, 200, 46)];
        [self.nordjylland setBackgroundColor:[UIColor clearColor]];
        self.nordjylland.text = @"Nordjylland";
        [self.nordjylland setTextAlignment:NSTextAlignmentCenter];
        [self.nordjylland setFrame:CGRectIntegral(self.nordjylland.frame)];
        self.nordjylland.textColor = [UIColor colorWithRed:0 green:0.23 blue:0.42 alpha:1];
        [self.nordjylland setFont:[UIFont fontWithName:@"Raleway" size:38]];
        [borderView addSubview:self.nordjylland];
        
        self.oestjylland = [[UILabel alloc] initWithFrame:CGRectMake(15, 98, 200, 46)];
        [self.oestjylland setBackgroundColor:[UIColor clearColor]];
        self.oestjylland.text = @"Østjylland";
        self.oestjylland.textColor = [UIColor colorWithRed:0 green:0.23 blue:0.42 alpha:1];
        [self.oestjylland setFont:[UIFont fontWithName:@"Raleway" size:38]];
        [borderView addSubview:self.oestjylland];
        
        self.vestjylland = [[UILabel alloc] initWithFrame:CGRectMake(15, 148, 240, 46)];
        [self.vestjylland setBackgroundColor:[UIColor clearColor]];
        self.vestjylland.text = @"Vestjylland";
        self.vestjylland.textColor = [UIColor colorWithRed:0 green:0.23 blue:0.42 alpha:1];
        [self.vestjylland setFont:[UIFont fontWithName:@"Raleway" size:38]];
        [borderView addSubview:self.vestjylland];
        
        self.sjaelland = [[UILabel alloc] initWithFrame:CGRectMake(15, 198, 240, 46)];
        [self.sjaelland setBackgroundColor:[UIColor clearColor]];
        self.sjaelland.text = @"Sjælland";
        self.sjaelland.textColor = [UIColor colorWithRed:0 green:0.23 blue:0.42 alpha:1];
        [self.sjaelland setFont:[UIFont fontWithName:@"Raleway" size:38]];
        [borderView addSubview:self.sjaelland];
        
        self.sonderjylland = [[UILabel alloc] initWithFrame:CGRectMake(15, 248, 240, 46)];
        [self.sonderjylland setBackgroundColor:[UIColor clearColor]];
        self.sonderjylland.text = @"Sønderjylland";
        self.sonderjylland.textColor = [UIColor colorWithRed:0 green:0.23 blue:0.42 alpha:1];
        [self.sonderjylland setFont:[UIFont fontWithName:@"Raleway" size:38]];
        [borderView addSubview:self.sonderjylland];
        
        self.fyn = [[UILabel alloc] initWithFrame:CGRectMake(15, 298, 240, 46)];
        [self.fyn setBackgroundColor:[UIColor clearColor]];
        self.fyn.text = @"Fyn";
        self.fyn.textColor = [UIColor colorWithRed:0 green:0.23 blue:0.42 alpha:1];
        [self.fyn setFont:[UIFont fontWithName:@"Raleway" size:38]];
        [borderView addSubview:self.fyn];
        
        self.testDrag = [[TestDragView alloc] initWithFrame:CGRectMake(0, self.view.frame.size.height/2 - 73, 320.0, 50.0)];
        self.testDrag.parentView = self.view;;
        [self.view addSubview:self.testDrag];
    }
}

#pragma mark Notification method

-(void)changeFontAcordingly:(NSNotification *)notification{
    CGPoint frame = CGPointFromString([notification object]);
    NSLog(@"Frame after animation is done: %f", frame.y);
    self.nordjylland.textColor = [UIColor colorWithRed:0 green:0.23 blue:0.42 alpha:1];
    self.oestjylland.textColor = [UIColor colorWithRed:0 green:0.23 blue:0.42 alpha:1];
    self.vestjylland.textColor = [UIColor colorWithRed:0 green:0.23 blue:0.42 alpha:1];
    self.sjaelland.textColor = [UIColor colorWithRed:0 green:0.23 blue:0.42 alpha:1];
    self.sonderjylland.textColor = [UIColor colorWithRed:0 green:0.23 blue:0.42 alpha:1];
    self.fyn.textColor = [UIColor colorWithRed:0 green:0.23 blue:0.42 alpha:1];
    NSNumber *pressedButton = nil;
    CGRect screenBounds = [[UIScreen mainScreen] bounds];
    if (screenBounds.size.height == 480) {
        // iphone 4,4s screen
        switch ((int)frame.y) {
            case 82:{
                self.nordjylland.textColor = [UIColor redColor];
                pressedButton = [NSNumber numberWithInt:0];;
                [self performSelector:@selector(moveNextView:) withObject:pressedButton afterDelay:0.6];
                NSError *error;
                [[GANTracker sharedTracker] trackPageview:@"Nordjylland" withError:&error];
            }
                break;
            case 132:{
                self.oestjylland.textColor = [UIColor redColor];
                pressedButton = [NSNumber numberWithInt:1];
                [self performSelector:@selector(moveNextView:) withObject:pressedButton afterDelay:0.6];
                NSError *error;
                [[GANTracker sharedTracker] trackPageview:@"Østjylland" withError:&error];
            }
                break;
            case 182:{
                self.vestjylland.textColor = [UIColor redColor];
                pressedButton = [NSNumber numberWithInt:2];
                [self performSelector:@selector(moveNextView:) withObject:pressedButton afterDelay:0.6];
                NSError *error;
                [[GANTracker sharedTracker] trackPageview:@"Vestjylland" withError:&error];
            }
                break;
            case 232:{
                self.sjaelland.textColor = [UIColor redColor];
                pressedButton = [NSNumber numberWithInt:3];
                [self performSelector:@selector(moveNextView:) withObject:pressedButton afterDelay:0.6];
                NSError *error;
                [[GANTracker sharedTracker] trackPageview:@"Sjaelland" withError:&error];
            }
                break;
            case 282:{
                self.sonderjylland.textColor = [UIColor redColor];
                pressedButton = [NSNumber numberWithInt:4];
                [self performSelector:@selector(moveNextView:) withObject:pressedButton afterDelay:0.6];
                NSError *error;
                [[GANTracker sharedTracker] trackPageview:@"Sønderjylland" withError:&error];
            }
                break;
            case 332:{
                self.fyn.textColor = [UIColor redColor];
                pressedButton = [NSNumber numberWithInt:5];
                [self performSelector:@selector(moveNextView:) withObject:pressedButton afterDelay:0.6];
                NSError *error;
                [[GANTracker sharedTracker] trackPageview:@"Fyn" withError:&error];
            }
                break;
            default:
                self.nordjylland.textColor = [UIColor colorWithRed:0 green:0.23 blue:0.42 alpha:1];
                self.oestjylland.textColor = [UIColor colorWithRed:0 green:0.23 blue:0.42 alpha:1];
                self.vestjylland.textColor = [UIColor colorWithRed:0 green:0.23 blue:0.42 alpha:1];
                self.sjaelland.textColor = [UIColor colorWithRed:0 green:0.23 blue:0.42 alpha:1];
                self.sonderjylland.textColor = [UIColor colorWithRed:0 green:0.23 blue:0.42 alpha:1];
                self.fyn.textColor = [UIColor colorWithRed:0 green:0.23 blue:0.42 alpha:1];
                
                break;
        }

    }else if (screenBounds.size.height == 568){
        //iphone 5 sceen
        switch ((int)frame.y) {
            case 100:{
                self.nordjylland.textColor = [UIColor redColor];
                pressedButton = [NSNumber numberWithInt:0];;
                [self performSelector:@selector(moveNextView:) withObject:pressedButton afterDelay:0.6];
                NSError *error;
                [[GANTracker sharedTracker] trackPageview:@"Nordjylland" withError:&error];
            }
                break;
            case 150:{
                self.oestjylland.textColor = [UIColor redColor];
                pressedButton = [NSNumber numberWithInt:1];
                [self performSelector:@selector(moveNextView:) withObject:pressedButton afterDelay:0.6];
                NSError *error;
                [[GANTracker sharedTracker] trackPageview:@"Østjylland" withError:&error];
            }
                break;
            case 200:{
                self.vestjylland.textColor = [UIColor redColor];
                pressedButton = [NSNumber numberWithInt:2];
                [self performSelector:@selector(moveNextView:) withObject:pressedButton afterDelay:0.6];
                NSError *error;
                [[GANTracker sharedTracker] trackPageview:@"Vestjylland" withError:&error];
            }
                break;
            case 250:{
                self.sjaelland.textColor = [UIColor redColor];
                pressedButton = [NSNumber numberWithInt:3];
                [self performSelector:@selector(moveNextView:) withObject:pressedButton afterDelay:0.6];
                NSError *error;
                [[GANTracker sharedTracker] trackPageview:@"Sjaelland" withError:&error];
            }
                break;
            case 300:{
                self.sonderjylland.textColor = [UIColor redColor];
                pressedButton = [NSNumber numberWithInt:4];
                [self performSelector:@selector(moveNextView:) withObject:pressedButton afterDelay:0.6];
                NSError *error;
                [[GANTracker sharedTracker] trackPageview:@"Sønderjylland" withError:&error];
            }
                break;
            case 350:{
                self.fyn.textColor = [UIColor redColor];
                pressedButton = [NSNumber numberWithInt:5];
                [self performSelector:@selector(moveNextView:) withObject:pressedButton afterDelay:0.6];
                NSError *error;
                [[GANTracker sharedTracker] trackPageview:@"Fyn" withError:&error];
            }
                break;
            default:
                self.nordjylland.textColor = [UIColor colorWithRed:0 green:0.23 blue:0.42 alpha:1];
                self.oestjylland.textColor = [UIColor colorWithRed:0 green:0.23 blue:0.42 alpha:1];
                self.vestjylland.textColor = [UIColor colorWithRed:0 green:0.23 blue:0.42 alpha:1];
                self.sjaelland.textColor = [UIColor colorWithRed:0 green:0.23 blue:0.42 alpha:1];
                self.sonderjylland.textColor = [UIColor colorWithRed:0 green:0.23 blue:0.42 alpha:1];
                self.fyn.textColor = [UIColor colorWithRed:0 green:0.23 blue:0.42 alpha:1];
                
                break;
        }

    }
    
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

-(void)moveNextView:(NSNumber *)pressedButton{
    MapViewController *mapvViewController = [[MapViewController alloc] init];
    mapvViewController.buttonPressed = [pressedButton intValue];
    [self.navigationController pushViewController:mapvViewController animated:YES];
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
