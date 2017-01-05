require 'sinatra'
require_relative 'config/application'
require 'pry'

set :bind, '0.0.0.0'  # bind to all interfaces

helpers do
  def current_user
    if @current_user.nil? && session[:user_id]
      @current_user = User.find_by(id: session[:user_id])
      session[:user_id] = nil unless @current_user
    end
    @current_user
  end
end

get '/' do
  redirect '/meetups'
end

get '/meetups' do
  erb :'meetups/index'
end

get '/meetups/new' do
  erb :'meetups/new'
end

get '/meetups/:meetup_id' do
  @meetup = Meetup.find(params[:meetup_id])
  erb :'meetups/show'
end


post '/meetups/new' do
  @name = params[:name]
  @location_name = params[:location_name]
  @location_address = params[:location_address]
  @description = params[:description]

  if current_user.nil?
    @error = 'Please sign in before creating an event.'
    erb :'meetups/new'
  elsif @name == ''
    @error = 'Please enter an event name.'
    erb :'meetups/new'
  elsif @location_name == ''
    @error = 'Please enter a location name.'
    erb :'meetups/new'
  elsif @description == ''
    @error = 'Please enter a description for your event.'
    erb :'meetups/new'
  else
      @this_location = Location.where(name: @location_name, address: @location_address)
      if @this_location.empty?
        @location = Location.create(name: @location_name, address: @location_address)
      else
        @location = @this_location[0]
      end

      @meetup = Meetup.create(name: @name, description: @description, location: @location, creator: current_user)

      if !@meetup.valid?
        @error = 'Your meetup is not valid, probably because there is already a meetup with the same name at the same location. Try something more unique!'
        erb :'meetups/new'
      else
        @success_message = "You successfully created a new meetup!"
        erb :'meetups/show'
      end

  end

end

post "/meetups/:meetup_id" do
  @meetup = Meetup.find(params[:meetup_id])

  if current_user.nil?
    @error = 'You must sign in before signing up for an event.'
    erb :'meetups/show'
  else
    @commitment = Commitment.create(user: current_user, meetup: @meetup)

    @path = '/meetups/' + @meetup.id.to_s

    redirect @path
  end

end

get '/auth/github/callback' do
  user = User.find_or_create_from_omniauth(env['omniauth.auth'])
  session[:user_id] = user.id
  flash[:notice] = "You're now signed in as #{user.username}!"

  redirect '/'
end

get '/sign_out' do
  session[:user_id] = nil
  flash[:notice] = "You have been signed out."

  redirect '/'
end
