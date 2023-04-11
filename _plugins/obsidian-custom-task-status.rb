# frozen_string_literal: true

Jekyll::Hooks.register [:notes], :post_convert do |doc|
  replace_cancelled_task(doc)
end

Jekyll::Hooks.register [:pages], :post_convert do |doc|
  # jekyll considers anything at the root as a page,
  # we only want to consider actual pages
  next unless doc.path.start_with?('_pages/')
  replace_cancelled_task(doc)
end

def replace_cancelled_task(doc)
  doc.content.gsub!(/\[-\]/, "<span>❌</span>")
end
