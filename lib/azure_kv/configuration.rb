module AzureKV
  module Configuration
    VALID_CONNECTION_KEYS = [:tenant_id, :client_id, :client_secret, :subscription_id, :vault_base_url, :api_version, :scope, :certificate_thumbprint, :certificate_private_key_file].freeze
    VALID_OPTIONS_KEYS    = [:format, :user_agent].freeze
    VALID_CONFIG_KEYS     = VALID_CONNECTION_KEYS + VALID_OPTIONS_KEYS

    DEFAULT_TENANT_ID     = 'TENANT_ID'
    DEFAULT_CLIENT_ID     = 'CLIENT_ID'
    DEFAULT_CLIENT_SECRET = 'CLIENT_SECRET'
    DEFAULT_SUBSCRIPTION_ID = 'SUBSCRIPTION_ID'
    DEFAULT_VAULT_BASE_URL = 'https://VAULT_NAME.vault.azure.net'
    DEFAULT_API_VERSION    = '7.3'
    DEFAULT_SCOPE         = 'https://vault.azure.net/.default'
    #DEFAULT_CERTIFICATE_THUMBPRINT = 'CERTIFICATE_THUMBPRINT'
    #DEFAULT_CERTIFICATE_PRIVATE_KEY_FILE = 'CERTIFICATE_PRIVATE_KEY_FILE'

    DEFAULT_USER_AGENT    = "API wrapper for Azure Key Vault #{AzureKV::VERSION}".freeze
    DEFAULT_FORMAT        = :json

    # Build accessor methods for every config options so we can do this, for example:
    # Awesome.format = :json
    attr_accessor(*VALID_CONFIG_KEYS)

    # Make sure we have the default values set when we get 'extended'
    def self.extended(base)
      base.reset
    end

    def reset
      self.tenant_id                    = DEFAULT_TENANT_ID
      self.client_id                    = DEFAULT_CLIENT_ID
      self.client_secret                = DEFAULT_CLIENT_SECRET
      self.subscription_id              = DEFAULT_SUBSCRIPTION_ID
      self.vault_base_url               = DEFAULT_VAULT_BASE_URL
      self.api_version                  = DEFAULT_API_VERSION
      self.scope                        = DEFAULT_SCOPE
      #self.certificate_thumbprint       = DEFAULT_CERTIFICATE_THUMBPRINT
      #self.certificate_private_key_file = DEFAULT_CERTIFICATE_PRIVATE_KEY_FILE

      self.user_agent                   = DEFAULT_USER_AGENT
      self.format                       = DEFAULT_FORMAT
    end

    def configure
      yield self
    end

    # Return the configuration values set in this module
    def options
      Hash[ * VALID_CONFIG_KEYS.map { |key| [key, send(key)] }.flatten ]
    end
  end
end