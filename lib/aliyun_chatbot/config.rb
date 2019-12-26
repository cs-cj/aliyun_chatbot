module AliyunChatbot

  class << self

    attr_accessor :config

    def configure
      yield self.config ||= Config.new
      config.instance_variables.each do |var_sym|
        singleton_class.define_method var_sym.to_s.gsub(/^@/, '').to_sym do
          config.instance_variable_get var_sym
        end
      end

    end


  end

  class Config
    attr_accessor :ak_id, :ak_secret
    # config/initialize/aliyun_chatbot.rb
    # AliyunChatbot.configure do |config|
    #   config.ak_id = ak_id from aliyun
    #   config.ak_secret = ak_secret from aliyun
    # end
  end



end