# frozen_string_literal: true

# Remove obsidian %%something%% in Markdown  in output HTML

Jekyll::Hooks.register [:notes], :pre_render do |doc|
  remove_obsidian_expander(doc)
end

def remove_obsidian_expander(doc)
  doc.content.gsub!(/```expander.+?```/m, "")
  doc.content.gsub!(/<-->/, "")
end
