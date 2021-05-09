class HttpRepository
  URL = 'https://api.github.com/repos/SepsiLaszlo/tc-rails-crawler'
  HEADERS = {
    "Authorization" => "token #{ENV["GITHUB_OAUTH_TOKEN"]}"
  }

  def self.get_pull_requests
    raw_pull_requests = HTTParty.get(URL + '/pulls', headers: HEADERS)
    raw_pull_requests.map do |pull_request|
      PullRequest.new(
        number: pull_request['number'],
        html_url: pull_request['html_url'],
        title: pull_request['title'])
    end
  end

  # commits listed in "#{url}/pulls/#{number}/commits" does not contain the changed file array
  def self.get_commits_for_pull_request(number)
    raw_commits = HTTParty.get("#{URL}/pulls/#{number}/commits", headers: HEADERS)
    commit_sha_s = raw_commits.map do |commit|
      commit['sha']
    end
    commit_sha_s.map do |commit_sha|
      raw_commit = get_commit(commit_sha)
      Commit.new(
        sha: raw_commit['sha'],
        file_names: raw_commit['files'].map{|file| file['filename']},
        html_url: raw_commit['html_url']
      )
    end
  end

  def self.get_commit(sha)
    Rails.logger.info "GET COMMIT #{sha}"
    HTTParty.get("#{URL}/commits/#{sha}", headers: HEADERS)
  end
end
