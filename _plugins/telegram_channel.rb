require "net/http"
require "uri"
require "json"
require "date"


class TelegramPublisher < Jekyll::Generator
    priority :low

    def generate(site)
        tgp_config = site.config['telegram_publisher']
        api_token = tgp_config['api_token'] || ENV['TELEGRAM_PUBLISHER_TOKEN']
        chat_id = tgp_config['chat_id']
        published_timedelta = tgp_config['published_timedelta'] || 5
        tags_for_publish = tgp_config['tags'] || []
        params = "chat_id=#{chat_id}, tags=#{tags_for_publish}, timedelta=#{published_timedelta}"

        Jekyll.logger.info  "Start telegram publisher with #{params}"

        if api_token && chat_id then
            note_to_publish = site.collections['notes'].docs.select {
                |note| (
                    note.data['tch-publish'] || tags_for_publish.intersection(note.data['tags'])
                ) && note.data['published_at']
            }
            note_to_publish.each do |current_note|
                # calculate minutes for published
                published_at = DateTime.iso8601(current_note.data['published_at'])
                now = DateTime.now
                minutes = ((now - published_at) * 24 * 60).to_i
                title = current_note.data['title']

                Jekyll.logger.debug "Check #{title} need publish #{minutes} minutes ago"

                if minutes >= 0 && minutes < published_timedelta then
                    message = current_note.content
                    result = send_telegram_message(api_token, chat_id, message)
                    if result["ok"] == true
                        Jekyll.logger.info "Sended to telegram #{title}"
                    else
                        Jekyll.logger.error "Error on sending telegram #{title}: #{result}"
                    end
                end
            end
        end
    end
end

def send_telegram_message(api_token, chat_id, message)
    url = URI.parse("https://api.telegram.org/bot" + api_token + "/sendMessage")
    params = { chat_id: chat_id, text: message, 'parse_mode': 'html' }.to_json
    response = Net::HTTP.post(url, params, 'Content-Type': 'application/json')
    response_body = JSON.parse(response.body)
    return response_body
end
