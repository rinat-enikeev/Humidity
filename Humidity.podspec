Pod::Spec.new do |spec|
  spec.name         = "Humidity"
  spec.version      = "0.0.4"
  spec.summary      = "Calculation of absolute humidity"
  spec.description  = <<-DESC
                        Use to calculate absolute humidity from relative.
                        DESC

  spec.homepage     = "https://github.com/rinat-enikeev/Humidity"
  spec.license      = { :type => "BSD", :file => "LICENSE" }
  spec.author             = { "Rinat Enikeev" => "rinat.enikeev@gmail.com" }
  spec.social_media_url   = "http://facebook.com/enikeev"
  spec.platform     = :ios, "10.0"
  spec.swift_version = '5.0'

  spec.source       = { :git => "https://github.com/rinat-enikeev/Humidity.git", :tag => spec.version.to_s }

  spec.source_files  = "Humidity/Source/**/*.{swift,h}"

end
