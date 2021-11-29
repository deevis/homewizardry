module JokeGenerator
  @registry = {
    "Cat Facts" => { call: ["https://cat-fact.herokuapp.com/facts/random"],
                     dig: "text"},

    "Dad Joke" => { call: ["https://icanhazdadjoke.com/", {accept: :json}],
                    dig: "joke" },

    "Trump Quote" => { call: ["https://www.tronalddump.io/random/quote"],
                    dig: "value"},
    "Chuck Norris" => { call: ["https://api.chucknorris.io/jokes/random"],
                    dig: "value"},
    "Programmer Joke" => { call: ["https://v2.jokeapi.dev/joke/Programming?blacklistFlags=nsfw,racist,sexist,explicit"],
                    extractor: ->(json){ json["joke"] || "#{json['setup']}\n#{json['delivery']}"}},

    "Christmas Joke" => { call: ["https://v2.jokeapi.dev/joke/Christmas?blacklistFlags=nsfw,racist,sexist,explicit"],
                    extractor: ->(json){ json["joke"] || "#{json['setup']}\n#{json['delivery']}"}},

    "Punny Joke" => { call: ["https://v2.jokeapi.dev/joke/Pun?blacklistFlags=nsfw,racist,sexist,explicit"],
                    extractor: ->(json){ json["joke"] || "#{json['setup']}\n#{json['delivery']}"}},

    "Spooky Joke" => { call: ["https://v2.jokeapi.dev/joke/Spooky?blacklistFlags=nsfw,racist,sexist,explicit"],
                    extractor: ->(json){ json["joke"] || "#{json['setup']}\n#{json['delivery']}"}},

    "Quotes" => { call: ["https://api.quotable.io/random"],
                    extractor: ->(json) { "#{json['author']} once said: #{json['content']}" }},

    "Bitcoin Price (blockchain.info)" => { call: ["https://blockchain.info/ticker"],
                    extractor: ->(json) { "Bitcoins price is currently $#{json.dig("USD", "last")}"}},

    "Bitcoin Price (coinbase)" => {call: ["https://api.coinbase.com/v2/prices/spot?currency=USD"],
                    extractor: ->(json) { "Bitcoins price is currently $#{json.dig("data", "amount")}"}},

    "Bitcoin Fear and Greed Index" => {call: ["https://api.alternative.me/fng/?limit=1"],
                    extractor: ->(json) {"Bitcoin Fear and Greed Index is currently at #{json['data'][0]['value']} - this is #{json['data'][0]['value_classification']}"} }
  }

  def self.start
    puts "Pick your joke type:"
    @registry.keys.each_with_index{ |k, i|  puts "#{i}. #{k}" }
    puts "#{@registry.size}. Tell me a random joke"
    response = gets.chomp.to_i
    response = (Random.rand * @registry.size).to_i if response >= @registry.keys.length
    selected_key = @registry.keys[response]
    puts tell_joke(selected_key)
  end

  def self.types
    @registry.keys
  end

  def self.tell_joke(key=nil)
    key ||= @registry.keys[(Random.rand * @registry.size).to_i]
    puts "Fetching a #{key}"
    config = @registry[key]
    # response = RestClient.get(*config[:call])
    url, headers = config[:call]
    response = RestClient::Resource.new(url, headers: headers, verify_ssl: false).get
    json = JSON.parse(response.body)
    return json.dig(config[:dig]) if config[:dig]
    return config[:extractor].call(json)
  end
end