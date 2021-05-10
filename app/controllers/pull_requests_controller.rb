class PullRequestsController < ApplicationController
  def index
    @pull_requests = HttpRepository.get_pull_requests
    @pull_requests = @pull_requests.sort_by do |pull_request|
      pull_request.files_changed_multiple_times? ? 0 : 1
    end
  end

  def show
    number = params[:number]
    @pull_request = HttpRepository.get_pull_request(number)
  end
end
