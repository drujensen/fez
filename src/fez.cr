require "./fez/*"
require "option_parser"
require "ecr/macros"

OptionParser.parse! do |parser|
  parser.banner = "Usage: fez NAME [--] [ARGS]"
  
  parser.on("-d DIR", "--directory=DIR", "Set the directory where the app will be built") do |dir| 
    Fez::DefaultOptions.directory = dir
  end
  
  parser.on("-t TEMPLATE", "--template=TEMPLATE", "Select a template. Options are slang, ecr, or api") do |template|
    if template.match(/slang|ecr|api/)
      Fez::DefaultOptions.template = template
    else
      raise Fez::Errors::InvalidTemplateError.new(template)
    end
  end

  parser.on("-f FRAMEWORK", "--framework=FRAMEWORK", "Select the framework. Options are `kemal` or `kemalyst`.") do |framework|
    if framework.match(/kemal(yst)?$/)
      Fez::DefaultOptions.framework = framework
    else
      raise Fez::Errors::InvalidFrameworkError.new(framework)
    end
  end

  parser.on("-v", "--version", "Fez version") { puts "Fez v#{Fez::VERSION}"; exit }
  parser.on("-h", "--help", "Show this help") { puts parser; exit }
end

# Start the application
Fez::CLI.run
