class PullRequestsController < ApplicationController
  def index
    @pull_requests = HttpRepository.get_pull_requests
    @pull_requests = @pull_requests.sort_by do |pull_request|
      pull_request.files_changed_multiple_times? ? 0 : 1
    end
  end
end
