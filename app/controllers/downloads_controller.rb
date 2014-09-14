class DownloadsController < ApplicationController
  def index
    redirect_to download_path(JOBS[0])
  end

  def show
    @job = JOBS.find {|repo| repo == params[:id]}
    @builds = get_builds(@job)

    @builds = Kaminari.paginate_array(@builds).page(params[:page]).per(10)
  end

  def get_builds(job)
    builds = Array.new
    require 'httparty'
    require 'json'

    response = HTTParty.get("http://ci.md-5.net/job/#{job}/api/json?pretty=true")
    json = JSON.parse(response.body)
    ci_builds = json['builds']
    ci_builds.each do |b|
      builds << {:id => b['number'], :url => b['url']}
    end
    builds 
  end
end
