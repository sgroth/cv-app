#!/usr/bin/env ruby

require 'optparse'
require 'yaml'
require 'erb'
require 'ostruct'

options = {}
OptionParser.new do |opts|
  opts.banner = "Usage: generate.rb [options]"
  options[:input] = 'cv.de.yaml'
  opts.on( '-i', '--input INPUT', 'input file' ) do |input|
    options[:input] = input
  end
  options[:private] = 'private.de.yaml'
  opts.on( '-p', '--private PRIVATE', 'private input file' ) do |private|
    options[:private] = private
  end
  options[:template] = 'cv.tex.erb'
  opts.on( '-t', '--template TEMPLATE', 'template file' ) do |template|
    options[:template] = template
  end
  options[:web] = false
  opts.on( '-w', '--web', 'create a web version omitting private information' ) do |w|
    options[:web] = true
  end
  options[:english] = false
  opts.on( '-e', '--english', 'create an english version' ) do |e|
    options[:english] = true
  end
end.parse!

# Ordering function
def by_year(data, &block)
  years = data.group_by {|hash| hash['year'] }
      .sort_by  {|year,| -year }
  block ? years.each(&block) : years
end

# Semi-hack to pass the correct bindings to ERB
class ErbBinding < OpenStruct
    def get_binding
        return binding()
    end
end

# Does the resume file exist?
abort("Error: #{options[:input]} is not present in this directory.  Use -i or --input to specify another input file.") unless File.exist?( options[:input] )

# Load the resume YAML files
resume = YAML::load( File.open(options[:input]) )

# Does the private input file exist?
abort("Error: #{options[:private]} is not present in this directory.  Use -p or --private to specify another private input file.") unless File.exist?( options[:private] ) or options[:web]

# Does the template file exist?
abort("Error: template #{options[:template]} is not present in the templates directory.  Use -t or --template to specify another template file.") unless File.exist?( 'templates/' + options[:template] )

input_basename, input_extension1, input_extension2 = options[:input].split('.')
template_basename, template_extension1, template_extension2 = options[:template].split('.')

if options[:web] && options[:english]
  output_file = input_basename + '.web.en.' + template_extension1
  load 'i18n/en.i18n'
elsif options[:web]
  output_file = 'cv.web.de.' + template_extension1
  load 'i18n/de.i18n'
elsif template_basename == "presentations"
  output_file = template_basename + "." + template_extension1
  load 'i18n/de.i18n'
elsif options[:english]
  output_file = input_basename + '.en.' + template_extension1
  load 'i18n/en.i18n'
  # Load and merge contact information (for full resume)
  # private.yaml contains contact information I don't want posted
  private = YAML::load( File.open("private.de.yaml") )
  resume["person"] = resume["person"].merge(private["person"])
else
  output_file = input_basename + '.de.' + template_extension1
  load 'i18n/de.i18n'
  # Load and merge contact information (for full resume)
  # private.yaml contains contact information I don't want posted
  private = YAML::load( File.open(options[:private]) )
  resume["person"] = resume["person"].merge(private["person"])
  resume["grantwriting"] = private["grantwriting"]
end

# Load the escape function and run it on resume hash (if escape function exists)
escape_defn = File.join( File.dirname(__FILE__), 'templates', '/escape_' + template_extension1 + '.rb' )
require escape_defn if File.exist?(escape_defn)
escape(resume) if defined?(escape)

# Load the ERB template
template = ERB.new( File.new('templates/' + options[:template]).read, 0, "<>" )
namespace = ErbBinding.new resume
result = template.result namespace.send(:get_binding)

# Create 'output' directory if it doesn't exist
Dir.mkdir("output") unless File.exist?("output") && File.directory?("output")

if options[:web]
  #Dir.mkdir("data") unless File.exist?("output") && File.directory?("data")
  if template_extension1 == 'md'
    File.open( '../_cv-data/' + output_file, "w" ) do |file|
      file.write result
    end
    puts "Created #{output_file} in _cv-data directory"
  end
end 

# Write to output file
File.open( 'output/' + output_file, "w" ) do |file|
  file.write result
end
puts "Created #{output_file} in output directory"
