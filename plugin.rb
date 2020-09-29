# name: plugin-check-topic-title
# about:  Checks topic title for various things
# version: 0.0.1
# authors: Terrapop

enabled_site_setting :plugin_check_topic_title_enabled

after_initialize do

      DiscourseEvent.on(:after_validate_topic) do |topic|
        begin
          if (SiteSetting.plugin_check_topic_title_enabled)
            if topic.title =~ /(http|www)/i
                topic.errors.add("Title", " must not contain a link or URL.")
            end
          end
        rescue => ex
          Rails.logger.error(ex.message)
          Rails.logger.error(ex.backtrace)
        end
      end

end