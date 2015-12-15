CHANGELOG - TYBlurImage
=========
### v1.1.0

#### Bug fixes

- Fix AssociationPolicy error

- Passively generate animation frames.

	Reference category will not affect the use of other UIImageView.

- When the frame data is not generated, the problem caused by the animation is played.

- image saturation mistake.

#### New features

- Add property downsampleBlurAnimationImage.

	Now you can choose whether to downsample the image.

### v1.2.0

- Use `UIImage+BlurEffects.h` replace `UIImageEffects.h`

- The following method adds `ty_` prefix

	* imageByApplyingLightEffectToImage:
	* imageByApplyingExtraLightEffectToImage:
	* imageByApplyingDarkEffectToImage:
	* imageByApplyingTintEffectWithColor:
	* imageByApplyingBlurToImage: withRadius: tintColor: saturationDeltaFactor: maskImage:
