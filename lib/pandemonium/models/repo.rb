require "ohm"
require "pandemonium/models/command"
require "pandemonium/models/job"

module Pandemonium
  module Models
    class Repo < Ohm::Model
      attribute :name
      attribute :repository

      list :commands, "Pandemonium::Models::Command"
      list :jobs,     "Pandemonium::Models::Job"
    end
  end
end
