namespace :bundle do

    task :build do
        fetch(:bundle_dirs).each do |bundle|
            Dir.glob[bundle[0]].each do |bundle_directory|
                bundle_name = File.basename(bundle_directory)
                bundle_glob = bundle_directory+bundle[1]
                bundle_output = ''
                Dir.glob[bundle_glob].each do |file|
                    bundle_extension = File.extname(file)
                    bundle_output << File.read(file)
                end
                build_target = fetch(:bundle_build_path)+bundle[2]+bundle_name+fetch(:bundle_build_suffix)+bundle_extension
                upload! build_output, build_target
            end
        end

    end
end


namespace :load do

    task :defaults do
        set :bundle_build_path, fetch(:deploy_to)
        set :bundle_dirs, [
            ["public/stylesheets/**/*/", "**/*.css", "public/stylesheets/build/"],
            ["public/javascripts/**/*/", "**/*.js",  "public/javascripts/build/"]
        ]
        set :bundle_build_suffix, "_combined"
    end

end

