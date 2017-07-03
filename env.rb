
task :start do
  sh "thin -p 4567 -D -R config.ru start"
end