require "ohm"

module Ohm
  module Utils
    SPLITTER = "::".freeze

    def self.const(context, name)
      if name =~ /#{SPLITTER}/
        context_namespaces = context.to_s.split(SPLITTER)
        name_namespaces = name.to_s.split(SPLITTER)

        common = (context_namespaces & name_namespaces)
        class_name = (name_namespaces - context_namespaces).last
        new_context = Object.const_get(common.shift)

        common.each { |space| new_context = new_context.const_get(space) }

        context = new_context
      end

      case name
      when Symbol, String then context.const_get(class_name)
      else name
      end
    end
  end
end

module Ohm
  class List
    alias << push
  end
end
