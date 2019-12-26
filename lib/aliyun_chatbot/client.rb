require "cgi"
module AliyunChatbot
  class Client
    include AliyunChatbot::Api
    # include AliyunChatbot::Config

    attr_accessor :ak_id, :ak_secret
  
    def initialize ak_id = nil, ak_secret = nil
      @ak_id = ak_id || AliyunChatbot.ak_id
      @ak_secret = ak_secret || AliyunChatbot.ak_secret
    end

    def send_message  instance_id, utterance, session_id = nil, knowledge_id = nil, sender_id = nil, sender_nick = nil, tag = nil
      whole_params = public_params.merge chat_params(instance_id, utterance, session_id, knowledge_id)
      whole_params.merge! sender_params(sender_id, sender_nick, tag)
      
      signature = signature(whole_params)
      whole_params.merge!({Signature: signature}) 

      puts "whole_params" 
      puts whole_params

      scheme = 'https'
      url = scheme + "://" + URL_BASE + "?" +params_to_string(whole_params)
      puts "url: " + url
      response = HTTP.get(url)
      JSON.parse(response) rescue nil
    end

    # todo
    def params_to_string(params)
      query = params.sort.map do |k, v|
        # v = v.to_json if v.to_s != '' && v.class != String 
        "#{CGI.escape(k.to_s)}=#{CGI.escape(v.to_s)}" if v.to_s != ''
      end.compact.join('&')
      puts "params_to_string"
      puts query
      query
    end

    def signature(params)
      string_to_sign = "GET" + "&" + "%2F" + params_to_string(params)
      signature = Base64.strict_encode64(OpenSSL::HMAC.digest('sha1', hmac_key, string_to_sign))
      signature
    end

    def hmac_key
      "#{ak_secret}&"
    end

  end
  
end