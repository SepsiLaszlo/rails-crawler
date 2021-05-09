class Commit < ApplicationRecord
  belongs_to :pull_request
  attr_accessor :file_names
  def initialize(attributes = nil)
    @file_names = []

    super
  end
end
