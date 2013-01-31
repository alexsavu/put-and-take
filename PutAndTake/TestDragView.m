//
//  TestDragView.m
//  PutAndTake
//
//  Created by Alexandru Savu on 8/5/12.
//
//

#import "TestDragView.h"
#import "ViewController.h"
#import "GANTracker.h"

@implementation TestDragView

@synthesize lastPoint = _lastPoint;
@synthesize parentView = _parentView;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.userInteractionEnabled = YES;
        self.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"selector.png"]];
        
    }
    
    return self;
}

- (void) touchesMoved:(NSSet*)touches withEvent:(UIEvent*)event {
    CGPoint pt = [[touches  anyObject] locationInView:self.parentView];
    
    //NSLog(@"dragging %f, %f", pt.x, pt.y);
    
    if(self.lastPoint.x != 0 && self.lastPoint.y != 0) {
        CGRect myFrame = self.frame;
        
    if(pt.y < self.lastPoint.y) {
        myFrame.origin.y = (myFrame.origin.y) - (self.lastPoint.y - pt.y);
    } else {
        myFrame.origin.y = (myFrame.origin.y) + (pt.y - self.lastPoint.y);
    }
        
        
        self.frame = myFrame;
        self.lastPoint = pt;
    } else {
        self.lastPoint = pt;
    }

}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{

}

- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event
{
    
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    ViewController *oneInstance = [ViewController sharedInstance];
    
    [UIView beginAnimations:nil context:nil];
    CGRect newFrame = self.frame;
    
    int lockLocation;

    int topDiff = ((int)(self.lastPoint.y/self.frame.size.height))*self.frame.size.height;
    int bottomDiff = ((int)(self.lastPoint.y/self.frame.size.height)+1)*self.frame.size.height;
    
    if(topDiff<100)
        topDiff = 100;

    if(bottomDiff>390)
        bottomDiff = 390;
    
    // checking which is closer
    if(topDiff < bottomDiff) {
        lockLocation = topDiff;
    } else {
        lockLocation = bottomDiff;
    }
    
    newFrame.origin.y = lockLocation;

    self.frame = newFrame;
    [UIView commitAnimations];
    
    NSLog(@"Current position: %f", newFrame.origin.y);
    
    // setting it back to zero so it doesn't get confused with the last point
    self.lastPoint = CGPointZero;
    
    oneInstance.nordjylland.textColor = [UIColor colorWithRed:0 green:0.23 blue:0.42 alpha:1];
    oneInstance.vestjylland.textColor = [UIColor colorWithRed:0 green:0.23 blue:0.42 alpha:1];
    
    switch ((int)newFrame.origin.y) {
        case 100:
        {
            oneInstance.nordjylland.textColor = [UIColor whiteColor];
            [[ViewController sharedInstance] performSelector:@selector(moveNextView) withObject:self afterDelay:0.6];
            [ViewController setPressedTag:0];
            
            [[GANTracker sharedTracker] setCustomVariableAtIndex:1
                                                            name:@"iPhone"
                                                           value:@"iv1"
                                                       withError:nil];
            
            [[GANTracker sharedTracker] trackEvent:@"button_click"
                                                 action:@"Nordjylland"
                                                  label:@"my_label"
                                                  value:99
                                                withError:nil];
        
        }
            break;
            
        case 150:
            oneInstance.vestjylland.textColor = [UIColor whiteColor];
            [[ViewController sharedInstance] performSelector:@selector(moveNextView) withObject:self afterDelay:0.6];
            [ViewController setPressedTag:1];
            break;
            
        default:
            oneInstance.nordjylland.textColor = [UIColor colorWithRed:0 green:0.23 blue:0.42 alpha:1];
            oneInstance.vestjylland.textColor = [UIColor colorWithRed:0 green:0.23 blue:0.42 alpha:1];
            
            break;
    }
    
}

-(void)repositionWith: (float)y
{
    ViewController *oneInstance = [ViewController sharedInstance];
    
    oneInstance.nordjylland.textColor = [UIColor colorWithRed:0 green:0.23 blue:0.42 alpha:1];
    oneInstance.vestjylland.textColor = [UIColor colorWithRed:0 green:0.23 blue:0.42 alpha:1];
    
    [UIView animateWithDuration:0.7 animations:^{
        CGRect newFrame = self.frame;
        if (y > 100 && y < 140) {
            newFrame.origin.y = 100;
        
        }
        self.frame = newFrame;
    
    } completion:^(BOOL finished){
        
        oneInstance.nordjylland.textColor = [UIColor whiteColor];
        [[ViewController sharedInstance] performSelector:@selector(moveNextView) withObject:self afterDelay:0.6];
        [ViewController setPressedTag:0];
    }];
}


/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect 
 { 
 // Drawing code 
 } 
 */ 


@end
