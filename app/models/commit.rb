class Commit < ApplicationRecord
  belongs_to :pull_request
  attr_accessor :file_names

  def initialize(attributes = nil)
    @file_names = []

    super
  end

  def self.create_from_json(json)
    new(sha: json['sha'],
        file_names: json['files'].map { |file| file['filename'] },
        html_url: json['html_url'],
        message: json['commit']['message'])
  end
end
