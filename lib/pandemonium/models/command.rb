require "pandemonium/models/repo"

module Pandemonium
  module Models
    class Command < Ohm::Model
      attribute :script
      attribute :type

      reference :repo, "Pandemonium::Models::Repo"
    end
  end
end
