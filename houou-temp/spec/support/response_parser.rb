module ResponseParser
  def json
    JSON.parse(response.body, symbolize_names: true)
  end

  def unsymbolized_json
    JSON.parse(response.body)
  end
end
