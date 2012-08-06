//
//  DraggableView.h
//  PutAndTake
//
//  Created by Alexandru Savu on 8/5/12.
//
//

#import <UIKit/UIKit.h>

@interface DraggableView : UIView

@property(nonatomic) CGPoint offset;
@property(nonatomic) CGPoint startLocation;
@property (nonatomic) CGPoint lastPoint;

@end
