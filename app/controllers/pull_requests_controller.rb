class PullRequestsController < ApplicationController
  def index
    @pull_requests = HttpRepository.get_pull_requests
  end
end
