Dir[File.join(Rails.root, "lib", "core_ext", "*.rb")].each {|l| require l }
Dir[File.join(Rails.root, "lib", "*.rb")].each {|l| require l }