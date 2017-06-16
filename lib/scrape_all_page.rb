require_relative 'get_page'
require_relative 'scrape_all_votes'
require_relative 'get_mps'


class GetPages
  def initialize
    @all_page = []
    $all_mp = GetMp.new
    url = "https://mkrada.gov.ua/content/rezultati-golosuvannya-deputativ_2.html"
    page = GetPage.page(url)
    page.css('.p-content__inner p').each do |p|
      @all_page << { cadent: p.text[/(\d{2}\.\d{2}\.\d{4})/].gsub(/(|)/,''), url: p.css('a')[0][:href] }
    end
  end
  def get_all_votes
    @all_page.each do |p|
      p p[:cadent]
      GetAllVotes.votes(p[:url], p[:cadent])
    end
  end
end
