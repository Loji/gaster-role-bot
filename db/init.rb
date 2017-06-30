
DB.create_table? :users do
  primary_key :id
  String :userEmail
  String :discordToken
end

DB.create_table? :servers do
  primary_key :id
  String :serverId
  String :serverName
end

DB.create_table? :userServers do
  primary_key :id
  Integer :serverId
  Integer :userId
end

DB.create_table? :serverQuestions do
  primary_key :id
  Integer :serverId
  String :question
  String :answers
end
