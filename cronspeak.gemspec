Gem::Specification.new do |s|
  s.name = 'cronspeak'
  s.version = '0.1.4'
  s.summary = 'Translates a cron expression into natural language'
  s.authors = ['James Robertson']
  s.files = Dir['lib/**/*.rb']
  s.signing_key = '../privatekeys/cronspeak.pem'
  s.cert_chain  = ['gem-public_cert.pem']
  s.license = 'MIT'
  s.email = 'james@r0bertson.co.uk'
  s.homepage = 'https://github.com/jrobertson/cronspeak'
  s.required_ruby_version = '>= 2.1.0'
end
