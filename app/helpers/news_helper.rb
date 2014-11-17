module NewsHelper
  def get_announcements
    response = HTTParty.get("http://forums.spongepowered.org/c/announcements.json")
    puts response
    json = JSON.parse(response.body)
    puts json
    topics = json['topic_list']['topics']
    announcements = Array.new
    topics.each do |topic|
      title = topic['title']
      posted_at = topic['created_at']
      id = topic['id']
      next if not id
      url = "http://forums.spongepowered.org/t/#{id}"
      puts url + '.json'
      thread_json = JSON.parse(HTTParty.get(url + '.json').body)
      thread = thread_json['post_stream']['posts'][0]
      author = thread['username']
      text = ActionView::Base.full_sanitizer.sanitize(thread['cooked'])
      announcements << {title: title, posted_at: posted_at, url: url, author: author, text: text}
    end
    announcements
  end
end