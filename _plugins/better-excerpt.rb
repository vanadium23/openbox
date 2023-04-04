
module Jekyll
  class Excerpt
    def extract_excerpt(doc_content)
      head, _, tail = doc_content.to_s.partition(doc.excerpt_separator)
      return head if tail.empty?      
      strip_wikilinks(head)
      head = sanctify_liquid_tags(head) if head.include?("{%")
      definitions = extract_markdown_link_reference_definitions(head, tail)
      return head if definitions.empty?

      head << "\n\n" << definitions.join("\n")
    end

    def strip_wikilinks(head)
      inline_matches = head.scan(WikiLinks::REGEX_WIKI_LINK_INLINES)
      if !inline_matches.nil? && inline_matches.size != 0
        inline_matches.each do |wl_match|
          filename = wl_match[0]
          title = wl_match[3]
          no_title = title.nil?
          if no_title
            pattern = "\[\[#{filename}\]\]"
            replacement = filename
          else
            pattern = /\[\[#{filename}\\?\|#{title}\]\]/
            replacement = title
          end
          head.gsub!(pattern, replacement)
        end
      end
    end

    def extract_markdown_link_reference_definitions(head, tail)
      [].tap do |definitions|
        tail.scan(MKDWN_LINK_REF_REGEX).each do |segments|
          definitions << segments.join if head.include?(segments[0])
        end
      end
    end
  end
end
