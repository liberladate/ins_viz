task :package do
  `mkdir -p build`
  `gnutar -cf build/ins_data_viz.tar.gz app/* public/* views/* config.ru app.rb Gemfile Gemfile.lock Rakefile`
end
