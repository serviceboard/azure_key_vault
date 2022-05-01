module AzureKV
  module HttpStatusCodes
    HTTP_OK_CODE = 200 # The request was successful.

    HTTP_BAD_REQUEST_CODE = 400 # The request was malformed.
    HTTP_UNAUTHORIZED_CODE = 401 # You did not provide the correct credentials.
    HTTP_FORBIDDEN_CODE = 403 # You are not allowed to access the resource.
    HTTP_NOT_FOUND_CODE = 404 # The resource you are looking for could not be found.
    HTTP_CONFLICT_CODE = 409 # The resource you are trying to create already exists.
    HTTP_UNPROCESSABLE_ENTITY_CODE = 422 # The request was well-formed but was unable to be followed due to semantic errors.
    HTTP_TOO_MANY_REQUESTS_CODE = 429 # You have exceeded the maximum number of requests.

    HTTP_SERVER_ERROR_CODE = 500 # The server encountered an error.
  end
end