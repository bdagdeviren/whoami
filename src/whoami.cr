require "grip"
require "totem"


class IndexController < Grip::Controllers::Http
  def get(context : Context) : Context
    json = totem = Totem.from_json context.request.headers.to_s.sub("HTTP::Headers","").gsub("=>",":")
    created_text = ""
    json.each do |key, value|
      created_text += "#{key.capitalize}: #{value} \n"
    end
    context
    .send_resp(created_text)
  end
end

class Application < Grip::Application
  def routes
    get "/", IndexController
  end
end

app = Application.new
app.run
