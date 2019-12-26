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
      url = scheme + "://" + URL_BASE + "?" + params_to_query_string(whole_params)
      puts "Final Get URL : " + url
      response = HTTP.get(url)
      # {"SessionId"=>"xxx", "Messages"=>[{"Text"=>{"Content"=>"", "AnswerSource"=>"NO_ANSWER"}, "Type"=>"Text", "Knowledge"=>{}}], "MessageId"=>"xxx", "RequestId"=>"xxx"}
      JSON.parse(response) rescue nil
    end

    # todo module
    def params_to_query_string(params)
      query = params.sort.map do |k, v|
        "#{percent_cncode(k)}=#{percent_cncode(v)}" if v.to_s != ''
      end.compact.join('&')
      # puts "URL before sign"
      # puts query
      query
    end

    # 注意：一般支持 URL 编码的库（比如 Java 中的 java.net.URLEncoder）都是按照“application/x-www-form-urlencoded”的 MIME 类型的规则进行编码的。实现时可以直接使用这类方式进行编码，把编码后的字符串中的加号“+”替换成“%20”、星号“*”替换成“%2A”、“%7E”替换回波浪号“~”，即可得到上述规则描述的编码字符串。
    def percent_cncode(str)
      CGI.escape(str.to_s).gsub("+", "%20").gsub("*", "%2A").gsub("%7E", "~")
    end

    def signature(params)
      string_to_sign = "GET" + "&" + "%2F" + "&"+ percent_cncode(params_to_query_string(params))
      # puts "StringToSign"
      # puts string_to_sign 
      signature = Base64.strict_encode64(OpenSSL::HMAC.digest('sha1', hmac_key, string_to_sign))
      signature
    end

    def hmac_key
      "#{ak_secret}&"
    end

  end

end