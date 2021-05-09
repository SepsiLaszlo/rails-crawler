class HttpRepository
  attr_accessor :url
  BASE_URL = 'https://api.github.com/repos'
  HEADERS = {
    "Authorization" => "token #{ENV["GITHUB_OAUTH_TOKEN"]}"
  }

  def initialize(owner, repo)
    @url = "#{BASE_URL}/#{owner}/#{repo}"
  end

  def get_pull_requests
    HTTParty.get(url + '/pulls', headers: HEADERS)
  end

  def get_commits_for_pull_request(id)
    HTTParty.get("#{url}/pulls/#{id}/commits", headers: HEADERS)
  end

  def get_commit(sha)
    HTTParty.get("#{url}/commits/#{sha}", headers: HEADERS)
  end
end
