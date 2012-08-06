//
//  TestDragView.m
//  PutAndTake
//
//  Created by Alexandru Savu on 8/5/12.
//
//

#import "TestDragView.h"

@implementation TestDragView

@synthesize lastPoint = _lastPoint;
@synthesize parentView = _parentView;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.userInteractionEnabled = YES;
        
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
    [UIView beginAnimations:nil context:nil];
    CGRect newFrame = self.frame;
    
    int lockLocation;

    int topDiff = ((int)(self.lastPoint.y/self.frame.size.height))*self.frame.size.height;
    int bottomDiff = ((int)(self.lastPoint.y/self.frame.size.height)+1)*self.frame.size.height;
    
    NSLog(@"%f", self.lastPoint.y);
    
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
    
    // setting it back to zero so it doesn't get confused with the last point
    self.lastPoint = CGPointZero;
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
