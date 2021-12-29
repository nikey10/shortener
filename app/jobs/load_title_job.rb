require 'open-uri'

class LoadTitleJob < ApplicationJob
  queue_as :default

  def perform(id)
    website = Website.find_by(id: id)
    if website
      uri = URI.parse(website.url)
      uri.open { |f| parse_html(f, website) }
    end

  rescue OpenURI::HTTPRedirect => redirect
    redirect.uri.open { |f| parse_html(f, website) }
  end

  private

  def parse_html(f, website)
    doc = Nokogiri::HTML(f)
    website.update(title: doc.at_css('title').text)
  end
end
