require "aliyun_chatbot/version"
require 'securerandom'
require 'json'
require "http"
require 'base64'
require 'digest/md5'
require 'aliyun_chatbot/config'
require 'aliyun_chatbot/api'
require 'aliyun_chatbot/client'

module AliyunChatbot
  class Error < StandardError; end
  # Your code goes here...
end
