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
    raw_pull_requests = HTTParty.get(url + '/pulls', headers: HEADERS)
    raw_pull_requests.map do |pull_request|
      PullRequest.new(number: pull_request['number'], html_url: pull_request['html_url'])
    end
  end

  # commits listed in "#{url}/pulls/#{number}/commits" does not contain the changed file array
  def get_commits_for_pull_request(number)
    raw_commits = HTTParty.get("#{url}/pulls/#{number}/commits", headers: HEADERS)
    commit_sha_s = raw_commits.map do |commit|
      commit['sha']
    end
    commit_sha_s.map do |commit_sha|
      raw_commit = get_commit(commit_sha)
      Commit.new(
        sha: raw_commit['sha'],
        file_names: raw_commit['files'].map{|file| file['filename']}
      )
    end
  end

  def get_commit(sha)
    HTTParty.get("#{url}/commits/#{sha}", headers: HEADERS)
  end
end
