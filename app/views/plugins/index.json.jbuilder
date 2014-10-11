json.plugins do 
	json.array!(@plugins) do |plugin|
	  json.extract! plugin, :id, :name, :views
	  json.author do
	  	json.username plugin.user.username
	  end
	  json.categories do 
	  	json.primary plugin.primary_category
	  	json.sub do
	  		json.array! plugin.tags.collect { |t| t.name }
	  	end
	  end
	  json.urls do
	  	json.display plugin_url(plugin)
	  	json.api plugin_url(plugin, format: :json)
	  end
	  json.downloads do
	  	json.count plugin.downloads
	  	if plugin.latest_download
	  		json.latest do
	  			json.file plugin.latest_download.file.file.filename
	  			json.downloads plugin.latest_download.downloads
	  			json.version plugin.latest_download.name
	  			json.path request.protocol + request.host_with_port + plugin.latest_download.file.url
	  		end
	  	end
	  end
	end
end