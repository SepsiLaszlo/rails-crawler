class HttpRepository
  URL = 'https://api.github.com/repos/rails/rails'

  HEADERS = {
    "Authorization" => "token #{ENV["GITHUB_OAUTH_TOKEN"]}"
  }

  def self.get_pull_requests
    Rails.logger.info 'GET PULL REQUESTS'
    pull_requests_json = HTTParty.get(URL + '/pulls', headers: HEADERS)
    pull_requests_json.map do |pull_request_json|
      PullRequest.create_from_json(pull_request_json)
    end
  end

  def self.get_pull_request(number)
    Rails.logger.info "GET PULL REQUEST #{number}"
    pull_request_json = HTTParty.get("#{URL}/pulls/#{number}", headers: HEADERS)
    PullRequest.create_from_json(pull_request_json)
  end

  # commits listed in "#{url}/pulls/#{number}/commits" does not contain the changed file array
  def self.get_commits_for_pull_request(number)
    raw_commits = HTTParty.get("#{URL}/pulls/#{number}/commits", headers: HEADERS)
    commit_sha_s = raw_commits.map do |commit|
      commit['sha']
    end
    commit_sha_s.map do |commit_sha|
      commit_json = get_commit(commit_sha)
      Commit.create_from_json(commit_json)
    end
  end

  def self.get_commit(sha)
    Rails.logger.info "GET COMMIT #{sha}"
    HTTParty.get("#{URL}/commits/#{sha}", headers: HEADERS)
  end
end
