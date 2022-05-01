# frozen_string_literal: true

require_relative "azure_kv/version"
require_relative "azure_kv/configuration"

module AzureKV
  autoload :Client, 'azure_kv/client'
  autoload :HttpStatusCodes, 'azure_kv/http_status_codes'
  autoload :Error, 'azure_kv/error'
  autoload :Object, 'azure_kv/object'
  autoload :Resource, "azure_kv/resource"

  # Classes used to return a nicer object wrapping the response data
  autoload :Secret, 'azure_kv/objects/secret'
  autoload :Instance, 'azure_kv/objects/instance'

  # High-level categories of Azure Key Vault API calls
  autoload :SecretResource, 'azure_kv/resources/secret'

  extend Configuration

  class << self
    attr_writer :logger

    def logger
      @logger ||= Logger.new('log/azure_kv.log', 'monthly', 1).tap do |log|
        log.level = Logger::INFO
        log.formatter = proc do |level, datetime, progname, msg|
          date_format = datetime.strftime("%Y-%m-%d %H:%M:%S")
          JSON.dump(time:"#{date_format}",level:"#{level.ljust(5)}",pid:"##{Process.pid}",message: msg) + "\n"
        end
      end
    end
  end
end
