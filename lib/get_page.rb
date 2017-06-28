require 'open-uri'
require 'nokogiri'
class GetPage
  def self.page(url)
    Nokogiri::HTML(open(url,ssl_verify_mode: OpenSSL::SSL::VERIFY_NONE, "User-Agent" => "HTTP_USER_AGENT:Mozilla/5.0 (Windows; U; Windows NT 6.0; en-US) AppleWebKit/534.13 (KHTML, like Gecko) Chrome/9.0.597.47"), nil, 'utf-8' )
  end
end
