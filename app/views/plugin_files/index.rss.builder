xml.instruct! :xml, :version => "1.0" 
xml.rss :version => "2.0" do
  xml.channel do
    xml.title "#{@plugin.name} Downloads"
    xml.description "Download feed for #{@plugin.name}"
    xml.link plugin_plugin_files_url

    for file in @downloads
      xml.item do
        xml.name file.name
        xml.pubDate file.created_at.to_s(:rfc822)
        xml.link plugin_plugin_file_url(@plugin, file)
        xml.guid plugin_plugin_file_url(@plugin, file)
      end
    end
  end
end