//
//  ItemListener.h
//  TfsCore
//
//  Created by CKC on 12/10/10.
//  All rights reserved. © Treasure Frontier System Sdn. Bhd.
//

#import <UIKit/UIKit.h>
//#import "ItemEvent.h"

@class ItemEvent;
@protocol ItemListener

- (void) itemStateChanged:(ItemEvent *) e;

@end
