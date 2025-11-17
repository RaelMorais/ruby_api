require 'sinatra'
require 'json'

set :bind, '0.0.0.0'

CARS = []
ID = Enumerator.new { |y| i = 1; loop { y << i; i += 1 } }


post "/cars" do
  data = JSON.parse(request.body.read)
  cars = { id: ID.next, model: data["model"], brand: data["brand"], year: data["year"] }
  CARS << cars
  content_type :json
  pessoa.to_json
end


get "/cars" do
  content_type :json
  CARS.to_json
end


get "/cars/:id" do
  cars = CARS.find { |p| p[:id] == params[:id].to_i }
  halt 404 unless cars
  content_type :json
  cars.to_json
end


put "/cars/:id" do
  data = JSON.parse(request.body.read)
  cars = CARS.find { |p| p[:id] == params[:id].to_i }
  halt 404 unless CARS
  cars[:model] = data["model"]
  content_type :json
  cars.to_json
end


delete "/cars/:id" do
  PESSOAS.reject! { |p| p[:id] == params[:id].to_i }
  status 204
end
