module Basecamp
  class Resource < ActiveResource::Base #:nodoc:
    class << self
      def parent_resources(*parents)
        @parent_resources = parents
      end

      def element_name
        name.split(/::/).last.underscore
      end

      def prefix_source
        @parent_resources.map { |resource| "/#{resource.to_s.pluralize}/:#{resource}_id/" }.join
      end

      def prefix(options={})
        if options.any?
          options.map { |name, value| "/#{name.to_s.chomp('_id').pluralize}/#{value}/" }.join
        else
          super
        end
      end
    end

    def prefix_options
      id ? {} : super
    end
  end
end
