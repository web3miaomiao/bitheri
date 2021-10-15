Pod::Spec.new do |s|
  s.name     = 'Bitheri-miaomiao'
  s.version  = '1.7.0'
  s.license  = 'Apache License, Version 2.0'
  s.summary  = 'bither\'s ios framework'
  s.homepage = 'http://bither.net'
  s.social_media_url = ''
  s.authors  = { 'miaomiao' => 'miaomiao@web3.com' }
  s.source   = { :git => 'git@github.com:web3miaomiao/bitheri.git', :submodules => true, :tag => "v#{s.version}"}
  s.requires_arc = true

  s.platform     = :ios
  s.ios.deployment_target = '10.0'

  s.source_files = 'Bitheri/Bitheri.{h,m}', 'Bitheri/{Models,Categories,Core,DatabaseProviders,Script,Bech32,Utils,Log}/*.{h,m}'

  s.dependency 'OpenSSL-Universal', '1.1.180'
  # s.dependency 'OpenSSL', '1.0.1j'
  s.dependency 'Reachability', '~> 3.1.1'
  s.dependency 'FMDB', '~> 2.3'
  s.dependency 'CocoaLumberjack', '~> 1.9.1'

end
