class RevisionsController < ApplicationController
  def show
    config_repos = REPOS
    @repos = Array.new
    config_repos.each do |repo|
      git_repo = GITHUB.repos.get(repo[:user], repo[:name])
      oss = false
      if git_repo.private
        oss = true
      end
      url = git_repo.html_url
      @repos << {:name => repo[:name], :friendly => repo[:friendly], :url => url, :private => oss, :user => repo[:user]}
    end
    @repo = @repos.find {|repo| repo[:name] == params[:id]}
    if not @repo
      return redirect_to revision_path("Spongy"), :alert => 'Revisions for that repository do not exist.'
    end
    @revisions = get_commits(@repo)
  end

  def index
  	redirect_to revision_path("Spongy")
  end

  def get_commits(repo)
  	# https://developer.github.com/v3/repos/commits/
  	commits = Array.new
  	github_commits = GITHUB.repos.commits.all(repo[:user], repo[:name])
  	github_commits.each do |response|
  		author = response.commit.author.name
  		sha = response.sha
  		url = response.html_url
  		message = response.commit.message
  		date = response.commit.author.date
  		commits << {:author => author, :sha => sha, :message => message, :date => date, :url => url}
  	end
  	commits = Kaminari.paginate_array(commits).page(params[:page]).per(10)
  end
end
