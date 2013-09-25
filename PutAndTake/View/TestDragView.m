//
//  TestDragView.m
//  PutAndTake
//
//  Created by Alexandru Savu on 8/5/12.
//
//

#import "TestDragView.h"
#import "ViewController.h"

#define MIN_POSITION_IPHONE5_Y 100.f
#define MIN_POSITION_Y 82.f
#define MAX_POSITION_Y 334.f
#define MAX_POSITION_IPHONE5_Y 350.f

#define iPHONE5_POSITION_PADDING 18.f
#define IS_IPHONE_5 ( fabs( ( double )[ [ UIScreen mainScreen ] bounds ].size.height - ( double )568 ) < DBL_EPSILON )

@interface TestDragView()

@property (assign, nonatomic) CGRect frameBeforeMove;

@end

@implementation TestDragView

@synthesize lastPoint = _lastPoint;
@synthesize parentView = _parentView;

- (id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.userInteractionEnabled = YES;
        self.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"selector the good one.png"]];
    }
    return self;
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    self.frameBeforeMove = self.frame;
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
    if (IS_IPHONE_5) {
        if (self.frame.origin.y < MIN_POSITION_IPHONE5_Y) {
            limitFrame.origin.y = MIN_POSITION_IPHONE5_Y;
            self.frame = limitFrame;
        }
        if (self.frame.origin.y > MAX_POSITION_IPHONE5_Y) {
            limitFrame.origin.y = MAX_POSITION_IPHONE5_Y;
            self.frame = limitFrame;
        }
    } else {
        if (self.frame.origin.y < MIN_POSITION_Y) {
            limitFrame.origin.y = MIN_POSITION_Y;
            self.frame = limitFrame;
        }
        if (self.frame.origin.y > MAX_POSITION_Y) {
            limitFrame.origin.y = MAX_POSITION_Y;
            self.frame = limitFrame;
        }
    }
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
    if (self.frameBeforeMove.origin.y == self.frame.origin.y || (self.frameBeforeMove.origin.y == 0)) {
        return;
    }
    CGRect screenBounds = [[UIScreen mainScreen] bounds];
    if (screenBounds.size.height == 480){
        //iphone 4,4s size
        __block CGRect newFrame = self.frame;
        [UIView animateWithDuration:0.3 animations:^{
            int lockLocation;
            
            int topDiff = ((int)(self.lastPoint.y/self.frame.size.height))*self.frame.size.height - iPHONE5_POSITION_PADDING;
            int bottomDiff = ((int)(self.lastPoint.y/self.frame.size.height)+1)*self.frame.size.height - iPHONE5_POSITION_PADDING;
            
            if(topDiff < 82.f)
                topDiff = 82.f;
            
            if (bottomDiff < 82.f) {
                bottomDiff = 82.f;
            }
            
            if(bottomDiff > MAX_POSITION_Y)
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
        
        // setting it back to zero so it doesn't get confused with the last point
        self.lastPoint = CGPointZero;

    }else if (screenBounds.size.height == 568){
        //iphone 5 size
        __block CGRect newFrame = self.frame;
        [UIView animateWithDuration:0.3 animations:^{
            int lockLocation;
            
            int topDiff = ((int)(self.lastPoint.y/self.frame.size.height))*self.frame.size.height;
            int bottomDiff = ((int)(self.lastPoint.y/self.frame.size.height)+1)*self.frame.size.height;
            
            if(topDiff<100)
                topDiff = 100;
            
            if(bottomDiff>MAX_POSITION_IPHONE5_Y)
                bottomDiff = MAX_POSITION_IPHONE5_Y;
            
            if (bottomDiff<100) {
                bottomDiff = 100;
            }
            
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
        
        // setting it back to zero so it doesn't get confused with the last point
        self.lastPoint = CGPointZero;

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
