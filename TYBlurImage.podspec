Pod::Spec.new do |s|
    s.name         = 'TYBlurImage'
    s.version      = '1.0.0'
    s.summary      = 'An easy way to set up blur effect and play the animation.'
    s.homepage     = 'https://github.com/luckytianyiyan/TYBlurImage'
    s.license      = 'MIT'
    s.authors      = {'luckytianyiyan' => 'luckytianyiyan@gmail.com'}
    s.platform     = :ios, '6.0'
    s.source       = {:git => 'https://github.com/luckytianyiyan/TYBlurImage.git', :tag => s.version}
    s.source_files = 'TYBlurImage/*'
    s.requires_arc = true
end
