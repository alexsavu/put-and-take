//
//  TestDragView.h
//  PutAndTake
//
//  Created by Alexandru Savu on 8/5/12.
//
//

#import <UIKit/UIKit.h>

@interface TestDragView : UIView

@property (nonatomic) CGPoint lastPoint;  
@property (nonatomic, retain) UIView *parentView; 
 
- (id)initWithFrame:(CGRect)frame; 
 

@end
