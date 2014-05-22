require 'redis'

conf_file = File.join('config','redis.yml')

$redis = if File.exists?(conf_file)
           conf = YAML.load(File.read(conf_file))
           conf[Application.config.env.to_s].blank? ? Redis.new : Redis.new(conf[Application.config.env.to_s])
         else
           Redis.new
         end
