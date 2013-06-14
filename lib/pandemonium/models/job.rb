require "ohm"
require "ohm/contrib"
require "pandemonium/models/repo"

module Pandemonium
  module Models
    class Job < Ohm::Model
      include Ohm::DataTypes

      attribute :start_time,  Type::Time
      attribute :end_time,    Type::Time
      attribute :exit_status, Type::Integer

      reference :repo, "Pandemonium::Models::Repo"

      def validate
        assert_present :repo
      end

      def running?; !!start_time end
      def finished?; !!end_time end

      def finish(exit_status)
        update_attributes(
          exit_status: exit_status,
          end_time: Time.now.utc
        )
      end

      def save
        super do |t|
          t.before { self.start_time = Time.now.utc }
        end
      end
    end
  end
end
