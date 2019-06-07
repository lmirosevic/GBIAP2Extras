Pod::Spec.new do |s|
  s.name                  = 'GBIAP2Extras'
  s.version               = '1.2.0'
  s.summary               = 'Extensions to GBIAP2'
  s.homepage              = 'https://github.com/lmirosevic/GBIAP2Extras'
  s.license               = { type: 'Apache License, Version 2.0', file: 'LICENSE' }
  s.author                = { 'Luka Mirosevic' => 'luka@goonbee.com' }
  s.source                = { git: 'https://github.com/lmirosevic/GBIAP2Extras.git', tag: s.version.to_s }
  s.ios.deployment_target = '6.0'
  s.requires_arc          = true
  s.source_files          = 'GBIAP2Extras/GBIAPExtras.h', 'GBIAP2Extras/GBIAPAnalyticsModule.{h,m}'
  s.public_header_files   = 'GBIAP2Extras/GBIAPExtras.h', 'GBIAP2Extras/GBIAPAnalyticsModule.h'

  s.dependency 'GBIAP2', '~> 3.0'
  s.dependency 'GBAnalytics', '~> 4.0'
  s.dependency 'GBDeviceInfo', '~> 6.0'

  s.dependency 'GBToolbox'
end
