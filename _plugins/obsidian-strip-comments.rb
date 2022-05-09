# frozen_string_literal: true

# Remove obsidian %%something%% in Markdown  in output HTML

Jekyll::Hooks.register [:notes], :pre_render do |doc|
  remove_obsidian_comments(doc)
end

def remove_obsidian_comments(doc)
  doc.content.gsub!(/%%.+?%%/m, "")
end
