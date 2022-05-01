# frozen_string_literal: true

require "faraday"

module AzureKV
  # The API wrapper client
  class Client
    # Define the same set of accessors as the AzureKV module
    attr_accessor(*Configuration::VALID_CONFIG_KEYS)
    attr_reader :adapter, :access_token

    def initialize(options = {}, adapter: Faraday.default_adapter, access_token: nil, stubs: nil)
      # Merge the config values from the module and those passed
      # to the client.
      merged_options = AzureKV.options.merge(options)

      # Copy the merged values to this client and ignore those
      # not part of our configuration
      Configuration::VALID_CONFIG_KEYS.each do |key|
        send("#{key}=", merged_options[key])
      end

      @adapter = adapter
      @stubs = stubs

      @access_token = nil
      @access_token = access_token || fetch_token
    end

    def secret
      SecretResource.new(self)
    end

    def connection
      @connection ||= Faraday.new(url: vault_base_url) do |conn|
        conn.request :authorization, "Bearer", access_token
        conn.request :json
        conn.response :json, content_type: "application/json"
        conn.adapter adapter, @stubs
      end
    end

    private

    def fetch_token
      base_url = "https://login.microsoftonline.com/#{tenant_id}/"
      token_url = "oauth2/v2.0/token"
      body = {
        client_id: client_id,
        client_secret: client_secret,
        grant_type: "client_credentials",
        scope: scope
      }

      AzureKV.logger.info "Fetching token from #{base_url}#{token_url}"

      @access_token ||= Faraday.new(url: base_url) do |conn|
        conn.request :url_encoded
        conn.response :json, content_type: "application/json"
        conn.adapter adapter, @stubs
      end.post(token_url, body).body["access_token"]

      @access_token
    end
  end
end
