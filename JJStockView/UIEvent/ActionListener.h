//
//  ActionListener.h
//  TfsCore
//
//  Created by CKC on 12/10/10.
//  All rights reserved. © Treasure Frontier System Sdn. Bhd.
//

#import <UIKit/UIKit.h>
#import "ActionEvent.h"


@protocol ActionListener

- (void) actionPerformed:(ActionEvent *) e;

@end
