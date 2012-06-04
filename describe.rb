#!/usr/bin/ruby

# @mf: Describe all mini frameworks in the current directory and all subdirectories

# usage: Just call this script in your main mini framework directory.
#        It will crawl all files in the current directory and sub directories.
#        Any file with a comment starting with ` @mf:{description}` will be included.
#        Any file ending with an extension in HEADER_FILE_EXTENSIONS will be included.
#        See line 3 for an example.



# This is how we search for the description
COMMENTS_BEGIN_WITH = [ "//", "#" ]
DESCRIPTION_BEGINS_WITH = "@mf:"
DESCRIPTION_REGEX = /^(?:#{COMMENTS_BEGIN_WITH.join("|")})\s*#{DESCRIPTION_BEGINS_WITH}(.*)/io
# Files ending with these extensions will be printed out even if they do not contain an mf description
HEADER_FILE_EXTENSIONS = [ ".h", ".rb" ]



# describe the mini framework that is this file
def describe_mini_framework file_name
  class_name = file_name.sub /\.\w+$/, ""
  
  # get description
  File.open(file_name) do |file|
    file.each_line do |line|
      if m = line.match(DESCRIPTION_REGEX)
        return "- #{class_name}:#{m[1]}"
      end
    end
  end
  
  # if this is a header with no description, return its name
  if file_name.end_with? *HEADER_FILE_EXTENSIONS
    "- #{class_name}"
  end
end

# describe all the mini frameworks in this directory and sub directories
def describe directory_name, directory_path
  sub_directories = Array.new
  description = String.new

  # go through every file
  Dir.chdir(directory_path) do
    Dir["*"].sort {|x,y| x.casecmp y }.each { |file_name|
      if File.directory? file_name
        sub_directories.push file_name
      else
        file_description = describe_mini_framework file_name
        description << file_description << "\n" unless file_description.nil? || file_description.empty?
      end
    }
  end

  # print description
  unless description.empty?
    unless directory_name.empty?
      puts "### #{directory_name} ###\n\n"
    end
    puts description + "\n"
  end

  # describe sub directories
  sub_directories.each { |sub_directory|
    describe("#{directory_name}/#{sub_directory}",
             File.join(directory_path, sub_directory))
  }
end

describe "", Dir.getwd