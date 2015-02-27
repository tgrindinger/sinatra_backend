require 'sinatra/cross_origin'

configure do
  enable :cross_origin
end

options '/*' do
  response.headers["Access-Control-Allow-Origin"] = "*"
  response.headers["Access-Control-Allow-Methods"] = "GET,DELETE,POST,PUT"
end

def put_json_body(symbol, record_type, body)
  t = record_type.get(body['id'])
  if t.nil?
    render_error(404, 'Unable to find record')
  else
    record_type.filter_fields(body).each {|k,v| t[k.to_sym] = v}
    t.save
    render_result(200, t)
  end
end

def post_json_body(symbol, record_type, body)
  render_result(201, record_type.create(record_type.filter_fields(body)))
end

def process_json_body(symbol, record_type, body, method)
  if body.class == Hash && body.size == 1 && body.keys.first.to_sym == symbol &&
      body.values.first.class == Hash
    if method == :put
      put_json_body(symbol, record_type, body[symbol.to_s])
    elsif method == :post
      post_json_body(symbol, record_type, body[symbol.to_s])
    else
      render_error(500, 'Invalid method')
    end
  else
    render_error(400, 'Invalid Request')
  end
end

def render_error(code, message)
  [code, {code: code, message: message}.to_json]
end

def render_result(code, result)
  if result == nil
    [404, {code: 404, message: 'Unable to find record'}.to_json]
  elsif result.errors.size > 0
    [400, {code: 400, message: result.errors.map {|e| e.first} }.to_json]
  else
    [code, {symbol: result}.to_json]
  end
end

def render_get(symbol, result)
  if result.nil?
    render_error(404, message: 'Unable to find record')
  else
    {symbol => result}.to_json
  end
end

def handle_get(symbol, record_type)
  if params[:id]
    t = record_type.get(params[:id])
  else
    t = record_type.all
  end
  render_get(symbol, t)
end

def handle_post(symbol, record_type)
  process_json_body(symbol, record_type, JSON.parse(request.body.read), :post)
end

def handle_put(symbol, record_type)
  process_json_body(symbol, record_type, JSON.parse(request.body.read), :put)
end

def handle_delete(record_type)
  t = record_type.get(params[:id])
  if t.nil?
    render_error(404, message: 'Unable to find record')
  end
  render_error(500, message: 'Server error') unless t.destroy
end
