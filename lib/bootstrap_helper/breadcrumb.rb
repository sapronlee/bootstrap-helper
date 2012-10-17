module BootstrapHelper
  module Breadcrumb
    def self.included(receiver)
      receiver.extend         ClassMethods
      receiver.send :include, InstanceMethods
      receiver.send :helper,  Helpers
      receiver.send :before_filter, :init_breadcrumbs
    end

    module ClassMethods

    end

    module InstanceMethods
      
      protected

      def init_breadcrumbs
        @breadcrumbs = []
      end

      def add_breadcrumb(title = nil, url = nil)
        if title && url
          @breadcrumbs.push("<a href=#{url}>#{title}</a>".html_safe)
        elsif title
          @breadcrumbs.push("<span>#{title}</span>".html_safe)
        end
      end

      def drop_page_title(title)
        @page_title = title
        return @page_title
      end

      def no_breadcrumbs
        @breadcrumbs = []
      end
      
    end

    module Helpers

      def render_breadcrumb
        return "" if @breadcrumbs.size <= 0
        crumb = "".html_safe

        @breadcrumbs.each do |c|
          crumb += content_tag(:li, c)
        end
        return content_tag(:ul, crumb, :class => "breadcrumb")
      end

  end
  
end