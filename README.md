### Capistrano Bundle

A fast and simple asset bundling extension for Capistrano 3.x


#### Modular Asset Capability

A common requirement is to split your css / js into modules organised by folder, so for instance you may have a setup like this:

    public/
      stylesheets/
        resets/
          fonts.css
          typography.css
          main.css
        core/
          headers.css
          colors.css
          navigation.css
        blog/
          styles.css
        news/
          styles.css

This capistrano bundle deployer, splits your assets up into modules based on the top-level directory, giving you combined builds of each. The above setup would yield the following build files:

    public/
      stylesheets/
        build/
          resets_combined.css
          core_combined.css
          blog_combined.css
          news_combined.css

A similar principle works for Javascript assest too.

#### Defaults and configuring

You'll need to add the gem to your Gemfile.

    gem 'capistrano-bundle'

Then add this to your Capfle:

    require 'capistrano/bundle'


The defaults are configure the above behaviour, but are completely customisable.

    set :bundle_build_path, fetch(:deploy_to)
    set :bundle_dirs, [
        ["public/stylesheets/*/", "**/*.css", "public/stylesheets/build/"],
        ["public/javascripts/*/", "**/*.js",  "public/javascripts/build/"]
    ]
    set :bundle_build_suffix, "_combined"


#### Contributing

This is a very early example of the functionality quite a few features and options are so-far unavailable. If there's something you'd lke to see open an issue.


