class PullRequestsController < ApplicationController
  def index
    http_repository = HttpRepository.instance
    @pull_requests = http_repository.get_pull_requests
  end
end
