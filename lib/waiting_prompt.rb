# ligne très importante qui appelle les gems.
require 'pry'
require 'http'
require 'json'
require 'faker'
require 'dotenv'
Dotenv.load('../.env')
# n'oublie pas les lignes pour Dotenv ici…




def generate_recipe(dish_name)
  api_key = ENV["OPENAI_API_KEY"]
  url = "https://api.openai.com/v1/engines/text-davinci-002/completions"

  

  headers = {
    "Content-Type" => "application/json",
    "Authorization" => "Bearer #{api_key}"
  }

  data = {

    
    "prompt" => gets.chomp, #Le bot attend une entrée de l'utilisateur grâce au "get.chomp"
    "max_tokens" => 500,
    "temperature" => 0.7
  }

  response = HTTP.post(url, headers: headers, body: data.to_json)
  response_body = JSON.parse(response.body.to_s)
  response_string = response_body['choices'][0]['text'].strip

  puts response_string
end

generate_recipe("")