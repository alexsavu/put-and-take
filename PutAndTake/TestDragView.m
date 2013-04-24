//
//  TestDragView.m
//  PutAndTake
//
//  Created by Alexandru Savu on 8/5/12.
//
//

#import "TestDragView.h"
#import "ViewController.h"

#define MIN_POSITION_Y 53.f
#define MAX_POSITION_Y 337.f

@implementation TestDragView

@synthesize lastPoint = _lastPoint;
@synthesize parentView = _parentView;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.userInteractionEnabled = YES;
        self.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"selector the good one.png"]];
    }
    return self;
}

- (void) touchesMoved:(NSSet*)touches withEvent:(UIEvent*)event {
    CGPoint pt = [[touches  anyObject] locationInView:self.parentView];
    
    if(self.lastPoint.x != 0 && self.lastPoint.y != 0) {
        CGRect myFrame = self.frame;
        
        if(pt.y < self.lastPoint.y) {
            myFrame.origin.y = (myFrame.origin.y) - (self.lastPoint.y - pt.y);
        }else{
            myFrame.origin.y = (myFrame.origin.y) + (pt.y - self.lastPoint.y);
        }
    self.frame = myFrame;
    self.lastPoint = pt;
    }else {
        self.lastPoint = pt;
    }
    CGRect limitFrame = self.frame;
    if (self.frame.origin.y < MIN_POSITION_Y) {
        limitFrame.origin.y = MIN_POSITION_Y;
        self.frame = limitFrame;
    }
    if (self.frame.origin.y > MAX_POSITION_Y) {
        limitFrame.origin.y = MAX_POSITION_Y;
        self.frame = limitFrame;
    }
    NSLog(@"dragging %f, %f", self.frame.origin.x, self.frame.origin.y);
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{

}

- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event
{
    
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
    __block CGRect newFrame = self.frame;
    [UIView animateWithDuration:0.3 animations:^{
        int lockLocation;
        
        int topDiff = ((int)(self.lastPoint.y/self.frame.size.height))*self.frame.size.height;
        int bottomDiff = ((int)(self.lastPoint.y/self.frame.size.height)+1)*self.frame.size.height;
        
        if(topDiff<100)
            topDiff = 100;
        
        if(bottomDiff>MAX_POSITION_Y)
            bottomDiff = MAX_POSITION_Y;
        
        // checking which is closer
        if(topDiff < bottomDiff) {
            lockLocation = topDiff;
        } else {
            lockLocation = bottomDiff;
        }
        newFrame.origin.y = lockLocation;
        self.frame = newFrame;
    } completion:^(BOOL finished) {
        [[NSNotificationCenter defaultCenter] postNotificationName:@"AnimationDone" object:NSStringFromCGPoint(CGPointMake(self.frame.origin.x, self.frame.origin.y))];
    }];
    
    NSLog(@"Current position: %f", newFrame.origin.y);
    
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
