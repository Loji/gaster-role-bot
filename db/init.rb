
DB.create_table? :users do
  primary_key :id
  String :discordId
  String :userEmail
end

DB.create_table? :servers do
  primary_key :id
  String :discordId
end

DB.create_table? :userServers do
  primary_key :id
  Integer :serverId
  Integer :userId
end

DB.create_table? :ranks do
  primary_key :id
  Integer :serverId
  String :name
end

DB.create_table? :userRanks do
  primary_key :id
  Integer :serverId
  Integer :userId
  Integer :rankId
  Boolean :rankSet
end

DB.create_table? :serverQuestions do
  primary_key :id
  Integer :serverId
  String :question
  String :answers
end
