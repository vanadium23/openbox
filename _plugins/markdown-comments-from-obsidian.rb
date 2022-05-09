# frozen_string_literal: true

# Remove obsidian %%something%% in Markdown  in output HTML

Jekyll::Hooks.register [:notes], :post_convert do |doc|
  remove_comment(doc)
end

Jekyll::Hooks.register [:pages], :post_convert do |doc|
  # jekyll considers anything at the root as a page,
  # we only want to consider actual pages
  next unless doc.path.start_with?('_pages/')
  remove_comment(doc)
end

def remove_comment(doc)
  doc.content.gsub!(/%%.+?%%/m, "")
end
