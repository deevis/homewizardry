class NodeRedService

  def self.url
    ENV['NODERED_URL']
  end

  def self.get(m, params = {})
    service_url = "#{url}/#{m}"
    puts "NodeRedService url: (GET)#{service_url}"
    puts "NodeRedService params: #{params}"
    response = RestClient.get(service_url, {params: params})
    JSON.parse(response.body)
  end

  def self.post(m, params = {})
    service_url = "#{url}/#{m}"
    headers = {"Content-Type" => "application/json"}
    puts "NodeRedService url: (POST)#{service_url}"
    puts "NodeRedService params: #{params}"
    response = RestClient.post(service_url, params, headers: headers)
    JSON.parse(response.body)
  end

end