module NewsHelper
  # returns an array of announcement hashes
  # can throw all sorts of errors due to Network problems or unexpected format
  def get_announcements
    response = HTTParty.get("https://forums.spongepowered.org/c/announcements.json")
    json = JSON.parse(response.body)
    announcements = []
    json["topic_list"]["topics"].each do |topic|
      title = topic["title"]
      posted_at = Time.parse(topic["created_at"])
      id = topic["id"]
      next unless id
      url = "https://forums.spongepowered.org/t/#{id}"
      user_id = topic["posters"].select!{ |p| p["description"].include? "Original Poster" }.first["user_id"]
      author = json["users"].select{ |u| u["id"] == user_id }.first["username"]
      text = HTTParty.get("https://forums.spongepowered.org/raw/#{id}") # Markdown
      announcements << {title: title, posted_at: posted_at, url: url, author: author, text: text}
    end
    announcements
  end
end