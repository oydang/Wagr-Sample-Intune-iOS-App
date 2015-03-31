//
//  ReportsViewController.h
//  ECHackDemoApp
//
//  Created by Joe on 3/30/15.
//  Copyright (c) 2015 Microsoft. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CorePlot-CocoaTouch.h"

@interface ReportsViewController : UIViewController<CPTPlotDataSource, UIDocumentInteractionControllerDelegate>
@property (weak, nonatomic) IBOutlet UIView *contentView;
@property (weak, nonatomic) IBOutlet UIButton *exportButton;
- (IBAction)onExportButtonPressed:(UIButton *)sender;

@end
