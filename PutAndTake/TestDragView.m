//
//  TestDragView.m
//  PutAndTake
//
//  Created by Alexandru Savu on 8/5/12.
//
//

#import "TestDragView.h"
#import "ViewController.h"

@implementation TestDragView

@synthesize lastPoint = _lastPoint;
@synthesize parentView = _parentView;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.userInteractionEnabled = YES;
        self.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"selector"]];
        
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
    
    if (newFrame.origin.y == 100.0) {
//        oneInstance.nordjylland.textColor = [UIColor colorWithRed:0.73 green:0.73 blue:0.73 alpha:1];
        oneInstance.nordjylland.textColor = [UIColor whiteColor];
        [[ViewController sharedInstance] performSelector:@selector(moveNextView) withObject:self afterDelay:0.6];
        [ViewController setPressedTag:0];
    }else if (newFrame.origin.y == 150.0){
        oneInstance.ostjylland.textColor = [UIColor whiteColor];
        [[ViewController sharedInstance] performSelector:@selector(moveNextView) withObject:self afterDelay:0.6];        
        [ViewController setPressedTag:1];
    }else{
        oneInstance.nordjylland.textColor = [UIColor colorWithRed:0 green:0.23 blue:0.42 alpha:1];
        oneInstance.ostjylland.textColor = [UIColor colorWithRed:0 green:0.23 blue:0.42 alpha:1];
    }
    
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
