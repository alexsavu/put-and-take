//
//  DraggableView.m
//  PutAndTake
//
//  Created by Alexandru Savu on 8/5/12.
//
//

#import "DraggableView.h"

@implementation DraggableView

@synthesize offset = _offset;
@synthesize startLocation = _startLocation;
@synthesize lastPoint = _lastPoint;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/


-(void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    
    UITouch *aTouch = [touches anyObject];
    
    self.offset = [aTouch locationInView: self];
}

-(void) touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *aTouch = [touches anyObject];
    CGPoint location = [aTouch locationInView:self.superview];
    
//    [UIView animateWithDuration:0.1f
//                          delay:0.f
//                        options:UIViewAnimationOptionCurveEaseInOut
//                     animations:^{
//                         self.frame = CGRectMake(0, location.y - self.offset.y,
//                                                 self.frame.size.width, self.frame.size.height);
//                     }
//                     completion:nil];
    
//    CGPoint pt = [[touches  anyObject] locationInView:self.superview];
//    
//    //NSLog(@"dragging %f, %f", pt.x, pt.y);
//    
//    if(self.lastPoint.x != 0 && self.lastPoint.y != 0) {
//        CGRect myFrame = self.frame;
//        
//            if(pt.y < self.lastPoint.y) {
//                myFrame.origin.y = (myFrame.origin.y) - (self.lastPoint.y - pt.y);
//            } else {
//                myFrame.origin.y = (myFrame.origin.y) + (pt.y - self.lastPoint.y);
//            }
//        
//        
//        self.frame = myFrame;
//        self.lastPoint = pt;
//    } else {
//        self.lastPoint = pt;
//    }
    
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *aTouch = [touches anyObject];
    CGPoint location = [aTouch locationInView:self.superview];
    
    [UIView beginAnimations:nil context:nil];
    CGRect newFrame = self.frame;
    
//    int lockLocation;
//
//    int topDiff = abs(self.lastPoint.y - self.topLock);
//    int bottomDiff = abs(self.lastPoint.y - self.bottomLock);
//    
//    // checking which is closer
//    if(topDiff < bottomDiff) {
//        lockLocation = self.topLock;
//    } else {
//        lockLocation = self.bottomLock;
//    }
    
    
    self.frame = newFrame;
    [UIView commitAnimations];
    
    // setting it back to zero so it doesn't get confused with the last point
    self.lastPoint = CGPointZero;
}


@end
