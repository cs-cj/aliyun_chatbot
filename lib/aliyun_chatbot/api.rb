# Dir["#{File.dirname(__FILE__)}/api/*.rb"].each do |path|
#   require path
# end
module AliyunChatbot
  module Api

    URL_BASE = "chatbot.cn-shanghai.aliyuncs.com"

    def public_params
      uuid = SecureRandom.uuid
      {
        Format: 'json', #	String 	否	返回值的类型，支持 JSON 与 XML。默认为 XML。
        Version: '2017-10-11', #	String	是	API 版本号，为日期形式：YYYY-MM-DD，本版本对应为2017-10-11。
        AccessKeyId: ak_id,	# String	是	阿里云颁发给用户的访问服务所用的密钥 ID。
        # Signature	String	是	签名结果串，关于签名的计算方法，请参见签名机制。
        SignatureMethod: 'HMAC-SHA1', #	String	是	签名方式，目前支持 HMAC-SHA1。
        Timestamp: Time.now.utc.iso8601, #	String	是	请求的时间戳。日期格式按照 ISO8601 标准表示，并需要使用UTC时间。格式为：YYYY-MM-DDThh:mm:ssZ，例如 2017-10-11T12:00:00Z （为北京时间 2017 年 10 月 11 日 20 点 0 分 0 秒）。
        SignatureVersion: 1.0, #	String	是	签名算法版本，目前版本是 1.0。
        SignatureNonce: uuid #,	String
      }
    end
    # module Some
    # end

    def chat_params( instance_id, utterance, session_id, knowledge_id)
      required =   {
        Action: 'Chat', #	String	是	系统规定参数，取值：Chat
        InstanceId: instance_id, #		String	是	机器人实例ID。登录云小蜜控制台，左侧面板选择开发者->基本配置，查看机器人示例信息，可获得该实例ID。
        Utterance: utterance, #		String	是	机器人访问者的输入
      }
      
      # String	否	
      # 会话ID，用于标识一个访问者的会话和保持上下文信息。
      # 对于一个新的访问者，首次调用Chat接口时无需传递此字段，机器人会开启一个会话，并在Chat接口的响应中返回该会话的SessionId。
      # 对于该访问者的后续轮次的会话，调用Chat接口时传递当前会话的SessionId，机器人即可基于SessionId继续该轮次会话。
      required.merge!({SessionId: session_id }) if session_id.to_s != ''
      
      #String	否	知识库词条的关联问题的ID。若指定此ID，那么机器人会直接返回指定的关联问题的答案
      required.merge!({KnowledgeId: knowledge_id }) if knowledge_id.to_s != ''
      
      # Perspective.1	String	否	视角编码，用于调用同一知识标题下不同视角的答案。在拼装请求参数时，需要以Perspective.1={视角编码}的格式传递参数。如：&Perspective.1=FZJBY3raWr。使用SDK时以SDK中定义的参数为准。目前仅支持一个视角答案的调用。
      required
    end

    def sender_params(sender_id, sender_nick, tag)
      optional = {

      }
      #	String	否	访问者ID。用于识别当前会话中的用户
      optional.merge!({SenderId: sender_id }) if sender_id.to_s != ''
      #		String	否	当前会话中访问的昵称
      optional.merge!({SenderNick: sender_nick }) if sender_nick.to_s != ''
      #		String	否	可以传递任何内容参数，该参数将会直接在返回结果中透传回来。
      optional.merge!({Tag: tag }) if tag.to_s != ''
      optional
    end
  end
end
