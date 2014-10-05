module PluginsHelper
  def categories_builder(plugin)
    sb = ''
    plugin.all_categories.each_with_index do |tag, index|
      sb += link_to tag, plugins_path(:category => tag), class: 'no-deco'
      if index != plugin.tags.size + 1 - 1
        sb += ', '
      end
    end
    sb.html_safe
  end
end
