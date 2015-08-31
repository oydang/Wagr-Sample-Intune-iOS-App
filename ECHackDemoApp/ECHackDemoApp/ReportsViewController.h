//
//  ReportsViewController.h
//  Wagr
//
//  Copyright (c) 2015 Microsoft. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ReportsViewController : UIViewController<UIDocumentInteractionControllerDelegate>
@property (weak, nonatomic) IBOutlet UIView *contentView;
@property (weak, nonatomic) IBOutlet UIButton *exportButton;
- (IBAction)onExportButtonPressed:(UIButton *)sender;

@end
