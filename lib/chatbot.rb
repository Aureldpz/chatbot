# ligne très importante qui appelle les gems.
require 'pry'
require 'http'
require 'json'
require 'faker'
require 'dotenv'
Dotenv.load('.env')
# n'oublie pas les lignes pour Dotenv ici…


# création de la clé d'api et indication de l'url utilisée.
def login_openai
  api_key = ENV["OPENAI_API_KEY"]
  url = "https://api.openai.com/v1/engines/text-babbage-001/completions"

# un peu de json pour faire la demande d'autorisation d'utilisation à l'api OpenAI
  headers = {
    "Content-Type" => "application/json",
    "Authorization" => "Bearer #{api_key}"
  }

# un peu de json pour envoyer des informations directement à l'API
  data = {
    "prompt" => "5 parfums de glace",
    "max_tokens" => 50,
    "temperature" => 1
  }

# une partie un peu plus complexe :
# - cela permet d'envoyer les informations en json à ton url
# - puis de récupéré la réponse puis de séléctionner spécifiquement le texte rendu
  response = HTTP.post(url, headers: headers, body: data.to_json)
  response_body = JSON.parse(response.body.to_s)
  response_string = response_body['choices'][0]['text'].strip
end

def generate_ice_cream_flavors
  flavors = []
  while  flavors.size < 5
    flavor = Faker::Dessert.flavor
    flavors << flavor unless flavors.include?(flavor)
  end
  flavors
end

# ligne qui permet d'envoyer l'information sur ton terminal
puts "Voici 5 parfums de glace :"
puts generate_ice_cream_flavors
