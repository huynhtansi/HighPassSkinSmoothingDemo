//
//  DefaultCIContextViewController.m
//  HighPassSkinSmoothingDemo
//
//  Created by Huynh Phuc on 11/18/17.
//  Copyright © 2017 Huynh Phuc. All rights reserved.
//

#import "DefaultCIContextViewController.h"

@interface DefaultCIContextViewController ()
    @property (weak, nonatomic) IBOutlet UIImageView *imageView;
    @property (weak, nonatomic) IBOutlet UISlider *amountSlider;
@end

@implementation DefaultCIContextViewController
    
    @synthesize sourceImage = _sourceImage;
    @synthesize context = _context;
    @synthesize filter = _filter;
    
- (void)setSourceImage:(UIImage *)sourceImage {
    self.inputCIImage = [CIImage imageWithCGImage:sourceImage.CGImage];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    _context = [CIContext contextWithOptions:@{kCIContextWorkingColorSpace:(__bridge id)colorSpace}];
    _filter = [[YUCIHighPassSkinSmoothing alloc]init];
}

- (void)processImage {
    [_filter setInputImage:self.inputCIImage];
    [_filter setInputAmount:[NSNumber numberWithFloat:self.amountSlider.value]];
    [_filter setInputRadius:[NSNumber numberWithFloat:7.0 * self.inputCIImage.extent.size.width/750.0]];
    
    CIImage *outputCIImage = self.filter.outputImage;
    
    CGImageRef outputCGImage = [_context createCGImage:outputCIImage fromRect:outputCIImage.extent];
    UIImage *outputUIImage = [[UIImage alloc]initWithCGImage:outputCGImage scale:_sourceImage.scale orientation:_sourceImage.imageOrientation];
    
    self.processedImage = outputUIImage;
    self.imageView.image = self.processedImage;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)addPhotoButtonTapped:(id)sender {
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    picker.allowsEditing = YES;
    picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    
    [self presentViewController:picker animated:YES completion:NULL];
}
    
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [picker dismissViewControllerAnimated:YES completion:NULL];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {
    [picker dismissViewControllerAnimated:YES completion:NULL];
    UIImage *chosenImage = info[UIImagePickerControllerEditedImage];
    _sourceImage = chosenImage;
    [self setSourceImage:chosenImage];
    [self processImage];
}
    
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
