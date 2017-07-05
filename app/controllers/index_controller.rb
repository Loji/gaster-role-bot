
class IndexController < ApplicationController
  get '/' do
    @servers = server
    erb :index
  end

  get '/server/:server_id' do
    @server_id = params[:server_id]
    erb :server
  end

  get '/server/:server_id/setRank/:rank' do
    user_ranks = @DB[:userRanks]
    server_id = get_server_id(params[:server_id])

    if user_ranks.where(
      serverId: server_id,
      userId: get_user_id
    ).count.zero?
      user_ranks.insert(
        serverId: server_id,
        userId: get_user_id,
        rankId: params[:rank],
        rankSet: true
      )
      'dodaliśmy to'
    else
      'mamy to'
    end
  end
end
