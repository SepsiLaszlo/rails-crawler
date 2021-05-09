class PullRequest < ApplicationRecord
  def commits
    @commits ||= HttpRepository.get_commits_for_pull_request(number)
  end

  Change = Struct.new(:file_name, :commits)

  def change_list
    return @change_list if @change_list

    changes_by_file_name = {}
    commits.each do |commit|
      commit.file_names.each do |file_name|
        record = changes_by_file_name[file_name]
        changes_by_file_name[file_name] = [commit] unless record
        record.push(commit) if record
      end
    end

    @change_list = changes_by_file_name.map{|k,v| Change.new(k, v)}
  end

  def files_changed_multiple_times?
    change_list.any? do |change|
      change.commits.count > 1
    end
  end
end
