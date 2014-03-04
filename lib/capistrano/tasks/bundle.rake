namespace :bundle do


    desc "Packages up assets into combined, modular files"
    task :build do
        fetch(:bundle_dirs).each do |bundle|
            Dir[bundle[0]].each do |bundle_directory|
                bundle_name = File.basename(bundle_directory)
                bundle_glob = bundle_directory+bundle[1]
                bundle_output = ''
                bundle_extension = ''
                Dir[bundle_glob].each do |file|
                    bundle_extension = File.extname(file)
                    bundle_output << File.read(file)
                end
                build_destination = fetch(:bundle_build_path)+"/"+bundle[2]
                build_target = build_destination+bundle_name+fetch(:bundle_build_suffix)+bundle_extension
                on roles(:web) do
                    unless test "[ -d #{build_destination} ]"
                        execute :mkdir, '-p', build_destination
                    end
                    upload! StringIO.new(bundle_output), build_target
                end
            end
        end

    end
end


namespace :load do

    task :defaults do
        set :bundle_build_path, -> { fetch(:deploy_to) }
        set :bundle_dirs, [
            ["public/stylesheets/*/", "**/*.css", "public/stylesheets/build/"],
            ["public/javascripts/*/", "**/*.js",  "public/javascripts/build/"]
        ]
        set :bundle_build_suffix, "_combined"
    end

end