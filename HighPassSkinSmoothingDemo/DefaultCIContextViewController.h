//
//  DefaultCIContextViewController.h
//  HighPassSkinSmoothingDemo
//
//  Created by Huynh Phuc on 11/18/17.
//  Copyright © 2017 Huynh Phuc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <YUCIHighPassSkinSmoothing.h>

@interface DefaultCIContextViewController : UIViewController <UIImagePickerControllerDelegate, UINavigationControllerDelegate>

    @property (nonatomic, retain) CIContext *context;
    @property (nonatomic, retain) YUCIHighPassSkinSmoothing *filter;
    @property (nonatomic, retain) CIImage *inputCIImage;
    @property (nonatomic, retain) UIImage *processedImage;
    @property (nonatomic, retain) UIImage *sourceImage;
    
    - (void)processImage;
@end
