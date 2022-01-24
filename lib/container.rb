require 'dry/system/container'

class Container < Dry::System::Container
  configure do |config|
    config.root = Pathname(".")

    # This is the line that's needed to fix this.
    # But it would be nice to raise an # error on `finalize!`.
    # Else, the component isn't actually accessible at all, since the
    # inflection from "html" to a constant is wrong
    # `UnresolvableComponentError`?
    # config.inflector = Dry::Inflector.new { |i| i.acronym("HTML") }

    config.component_dirs.add "lib" do |dir|
      dir.namespaces.add_root const: nil
    end
  end
end

Container.finalize!

p Container.keys

puts Container["api"].call
puts Container["html"].call
