module AzureKV
  class Resource
    include HttpStatusCodes

    attr_reader :client

    def initialize(client)
      @client = client
    end

    def get_request(url, params = {}, headers = {})
      handle_response client.connection.get("#{url}?api-version=#{client.api_version}", params, default_headers.merge(headers))

    rescue Faraday::ConnectionFailed => e
      AzureKV.logger.error "Connection error: #{e.message}"
      raise AzureKV::Error::ConnectionError, e
    end

    def put_request(url, body = {}, headers = {})
      handle_response client.connection.put("#{url}?api-version=#{client.api_version}", body, default_headers.merge(headers))

    rescue Faraday::ConnectionFailed => e
      AzureKV.logger.error "Connection error: #{e.message}"
      raise AzureKV::Error::ConnectionError, e
    end

    def delete_request(url, params = {}, headers = {})
      handle_response client.connection.delete("#{url}?api-version=#{client.api_version}", params, default_headers.merge(headers))

    rescue Faraday::ConnectionFailed => e
      AzureKV.logger.error "Connection error: #{e.message}"
      raise AzureKV::Error::ConnectionError, e
    end

    def default_headers
      {
        'Content-Type' => 'application/json',
        'Accept' => 'application/json'
      }
    end

    def handle_response(response)
      case response.status
      when HTTP_OK_CODE
      when HTTP_BAD_REQUEST_CODE
        AzureKV.logger.error "Bad request: #{response.body}"
        raise AzureKV::Error::BadRequest.new(response)
      when HTTP_UNAUTHORIZED_CODE
        AzureKV.logger.error "Unauthorized: #{response.body}"
        raise AzureKV::Error::UnauthorizedAccess.new(response)
      when HTTP_FORBIDDEN_CODE
        AzureKV.logger.error "Forbidden: #{response.body}"
        raise AzureKV::Error::ForbiddenAccess.new(response)
      when HTTP_NOT_FOUND_CODE
        AzureKV.logger.error "Not found: #{response.body}"
        raise AzureKV::Error::ResourceNotFound.new(response)
      when HTTP_CONFLICT_CODE
        AzureKV.logger.error "Conflict: #{response.body}"
        raise AzureKV::Error::ResourceConflict.new(response)
      when HTTP_UNPROCESSABLE_ENTITY_CODE
        AzureKV.logger.error "Unprocessable entity: #{response.body}"
        raise AzureKV::Error::UnprocessableEntity.new(response)
      when HTTP_TOO_MANY_REQUESTS_CODE
        AzureKV.logger.error "Too many requests: #{response.body}"
        raise AzureKV::Error::TooManyRequests.new(response)
      when HTTP_SERVER_ERROR_CODE
        AzureKV.logger.error "Server error: #{response.body}"
        raise AzureKV::Error::ServerError.new(response)
      end

      response
    end
  end
end