require 'rest-client'
require 'json'

class Translator
  def initialize
    @url = 'https://translate.yandex.net/api/v1.5/tr.json/translate'
    @url_detector = 'https://translate.yandex.net/api/v1.5/tr.json/detect'
    @url_list = 'https://translate.yandex.net/api/v1.5/tr.json/getLangs'
    @key = '<Put your key here>'
    main
  end

  def translate
    response = RestClient.post( @url,
    {
      key: @key,
      text: @text,
      lang: "#{@origin}-#{@destiny}"
    })
    puts "Translating..."
    JSON.parse(response)['text']
  end

  def detector
    response = RestClient.post( @url_detector,
      {
        key: @key,
        text: @text
      })
      @origin = JSON.parse(response)['lang']
  end

  def list
    response = RestClient.post( @url_list,
      {
        key: @key,
        ui: @origin
      })
    return JSON.parse(response)['langs'].each do |key, value|
      puts "Código: #{key} - Idioma: #{value}"
    end
  end

  def main
    print "Enter your text: "
    @text = gets.chomp
    detector
    puts "We have detected the language is: #{@origin}."
    sleep(1)
    list
    print "Enter the translation code: "
    @destiny = gets.chomp
  end
end