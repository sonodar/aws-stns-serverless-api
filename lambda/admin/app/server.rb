# https://github.com/aws-samples/serverless-sinatra-sample/blob/master/app/server.rb
require 'sinatra'
require 'sinatra-validation'
require 'aws-record'
require 'logger'

logger = Logger.new(STDOUT)

before do
  content_type :json
  # ↓↓↓ ここからサンプルコードまま ↓↓↓
  if request.body.size > 0
    request.body.rewind
    @params ||= Sinatra::IndifferentHash.new
    @params.merge!(JSON.parse(request.body.read))
  end
  # ↑↑↑ ここまでサンプルコードまま ↑↑↑
  authz_context = JSON.parse(ENV['AUTHORIZATION_CONTEXT'] || '{}')
  @authz_context = AuthorizationContext.new(authz_context)
  logger.debug("params = #{params}")
  logger.debug("authorization_context = #{@authz_context}")
end

get '/users' do; end
get '/users/{name}' do; end

# POST /users
#
# -- 事前条件 --
# name が指定されていない場合は 400 エラーとなること
# name に不正な文字 (/\A[a-zA-Z][a-zA-Z0-9_.\-]+\z/) が含まれていたら 400 エラーとなること
# name が 16 文字を超えていたら 400 エラーとなること
# keys が指定されていない場合は 400 エラーとなること
# keys が空の場合は 400 エラーとなること
# keys がリストでない場合は 400 エラーとなること
# auto_id が true でない場合に id がない場合は 400 エラーとなること
# auto_id が true の場合に id が指定されていたら 400 エラーとなること
# id が整数でなければ 400 エラーとなること
# id が 1 〜 65535 の範囲外だったら 400 エラーとなること
# id がすでに存在する値だった場合は 400 エラーとなること
# auto_group が true でない場合に group_id がない場合は 400 エラーとなること
# auto_group が true の場合に group_id が指定されていたら 400 エラーとなること
# group_id が存在しない値だった場合は 400 エラーとなること
# shell が path として不正な場合 (/\A\/[a-zA-Z0-9._\-]+(?:\/[a-zA-Z0-9._\-]+)*\z/) は 400 エラーとなること
# directory が path として不正な場合は 400 エラーとなること
# groups がリストでない場合は 400 エラーとなること
# groups に存在しないグループがあったら 400 エラーとなること
# link_users がリストでない場合は 400 エラーとなること
# link_users に存在しないユーザーがあったら 400 エラーとなること
#
# -- 事後条件 --
# 入力エラーがなければ指定したパラメータでユーザーが作成されること
# auto_id が true の場合に id が自動採番されること
# auto_group が true の場合に name, id と同じ名称, GID でグループが作成されること
# auto_group が true の場合に id がすでに存在した場合は increment された gid が採番されること
# shell を指定していない場合は /bin/bash となること
# directory を指定していない場合は /home/#{name} となること
post '/users' do; end
put '/users/{name}' do; end
delete '/users/{name}' do; end

get '/groups' do; end
get '/groups/{name}' do; end
post '/groups' do; end
put '/groups/{name}' do; end
delete '/groups/{name}' do; end
