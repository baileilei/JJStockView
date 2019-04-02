//
//  ChangeListener.h
//  TfsCore
//
//  Created by CKC on 12/10/10.
//  All rights reserved. © Treasure Frontier System Sdn. Bhd.
//

#import <UIKit/UIKit.h>
//#import "ChangeEvent.h"

@class ChangeEvent;
@protocol ChangeListener

- (void) stateChanged:(ChangeEvent *) e;
@end
