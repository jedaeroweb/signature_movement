xml.instruct! :xml, :version => "1.0"
xml.rss :version => "2.0" do
  xml.channel do
    xml.title @application_name
    xml.author 'Sleeping-Lion'
    xml.description @meta_description
    xml.link t(:site_full_url)
    xml.language I18n.locale.to_s

    for user in @users
      xml.item do
        if user.name
          xml.title user.name
        else
          xml.title ''
        end
        xml.author 'SleepingLion'
        xml.pubDate user.created_at.strftime("%a, %d %b %Y %H:%M:%S %z")
        xml.link t(:site_full_url)+ '/users/' + user.id.to_s
        xml.guid user.id

        if user.description
          text = user.description
          # if you like, do something with your content text here e.g. insert image tags.
          # Optional. I'm doing this on my website.
          xml.description "<p>" + text + "</p>"
        end
      end
    end

    for article in @reports
      xml.item do
        if article.title
          xml.title article.title
        else
          xml.title ''
        end
        xml.author 'SleepingLion'
        xml.pubDate article.created_at.strftime("%a, %d %b %Y %H:%M:%S %z")
        xml.link t(:site_full_url)+ '/reports/' + article.id.to_s
        xml.guid article.id

        text = article.content.to_plain_text
		# if you like, do something with your content text here e.g. insert image tags.
		# Optional. I'm doing this on my website.
        xml.description "<p>" + text + "</p>"
      end
    end

    for article in @compliments
      xml.item do
        if article.title
          xml.title article.title
        else
          xml.title ''
        end
        xml.author 'SleepingLion'
        xml.pubDate article.created_at.strftime("%a, %d %b %Y %H:%M:%S %z")
        xml.link t(:site_full_url)+ '/compliments/' + article.id.to_s
        xml.guid article.id

        text = article.content.to_plain_text
		# if you like, do something with your content text here e.g. insert image tags.
		# Optional. I'm doing this on my website.
        xml.description "<p>" + text + "</p>"
      end
    end

  end
end
