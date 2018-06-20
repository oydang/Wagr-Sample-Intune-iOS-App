//
//  ReportsViewController.h
//  Wagr
//
//  Copyright © Microsoft. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ReportsViewController : UIViewController<UIDocumentInteractionControllerDelegate>

@property (weak, nonatomic) IBOutlet UIView *contentView;
@property (weak, nonatomic) IBOutlet UIButton *exportWagesButton;
@property (weak, nonatomic) IBOutlet UIButton *exportWorkerDataButton;

- (IBAction)onExportWagesButtonPressed:(UIButton *)sender;
- (IBAction)onExportWorkerDataButtonPressed:(id)sender;

@end
