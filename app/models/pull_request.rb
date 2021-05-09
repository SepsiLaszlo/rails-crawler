class PullRequest < ApplicationRecord
  def commits
    @commits ||= HttpRepository.instance.get_commits_for_pull_request(number)
  end
end
