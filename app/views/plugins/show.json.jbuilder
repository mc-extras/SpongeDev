json.extract! @plugin, :id, :name, :body, :summary, :updated_at, :created_at
json.license do
	if @plugin.license == "Custom"
		json.custom true
		json.license @plugin.custom_license
		json.text @plugin.custom_text
	else
		json.custom false
		json.license @plugin.license
		json.text ""
	end
end
json.categories do 
	json.primary @plugin.primary_category
	json.sub do
		json.array! @plugin.tags.collect { |t| t.name }
	end
end
json.downloads do
	json.count @plugin.downloads
	if @plugin.latest_download
		json.latest do
			json.file @plugin.latest_download.file.file.filename
	  		json.downloads @plugin.latest_download.downloads
	  		json.version @plugin.latest_download.name
	  		json.path request.protocol + request.host_with_port + @plugin.latest_download.file.url
		end
	end
	json.all do
		json.array!(@plugin.plugin_files) do |download|
			json.extract! download, :id, :downloads, :mc_version
			json.file download.file.file.filename
	  		json.version download.name
	  		json.path request.protocol + request.host_with_port + download.file.url 
		end
	end
end
json.urls do
	json.display plugin_url(@plugin)
	json.api plugin_url(@plugin, format: :json)
	json.all plugins_url(format: :json, api: true)
end
