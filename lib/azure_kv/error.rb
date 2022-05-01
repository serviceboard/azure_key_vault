# frozen_string_literal: true

module AzureKV
  # Error class for AzureKV
  class Error
    class ConnectionError < StandardError # :nodoc:
      attr_reader :response, :status

      def initialize(response, message = nil)
        super(message)

        if response.respond_to?(:body)
          @response = Object.new response.body["error"]
          @status = response.status
        else
          @response = Object.new code: "Connection Failed",
                                 message: "Connection parameters for Azure Key Vault are invalid"
          @status = 503
        end

        @message = message
      end

      def to_h
        {
          status: status,
          title: title,
          message: message
        }
      end

      def serializable_hash
        to_h
      end

      def to_s
        to_h.to_s
      end

      def title
        response.code
      end

      def message
        response.message
      end
    end

    # 4xx Client Error
    class ClientError < ConnectionError # :nodoc:
    end

    # 400 Bad Request
    class BadRequest < ClientError # :nodoc:
    end

    # 401 Unauthorized
    class UnauthorizedAccess < ClientError # :nodoc:
    end

    # 403 Forbidden
    class ForbiddenAccess < ClientError # :nodoc:
    end

    # 404 Not Found
    class ResourceNotFound < ClientError # :nodoc:
    end

    # 409 Conflict
    class ResourceConflict < ClientError # :nodoc:
    end

    class UnprocessableEntity < ClientError # :nodoc:
    end

    # 429 Too Many Requests
    class TooManyRequests < ClientError # :nodoc:
    end

    # 5xx Server Error
    class ServerError < ConnectionError # :nodoc:
    end
  end
end
