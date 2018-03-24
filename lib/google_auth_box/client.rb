require 'googleauth'
require 'googleauth/stores/file_token_store'
module GoogleAuthBox
  class Client
    def initialize(client_id_hash:, scopes:, data_file_path:, base_uri:)
      @base_uri = base_uri

      client_id = Google::Auth::ClientId.from_hash client_id_hash
      f = File.open data_file_path
      data_path = File.absolute_path f
      token_store = Google::Auth::Stores::FileTokenStore.new(
        :file => data_path
      )

      f.close

      @auth_client = Google::Auth::UserAuthorizer.new(
        client_id,
        scopes,
        token_store,
        base_uri
      )

      def get_auth_url
        @auth_client.get_authorization_url(base_url: @base_uri)
      end

      def get_creds(id)
        @auth_client.get_credentials(id)
      end

      def save_creds(id, code)
        @auth_client.get_and_store_credentials_from_code(
          user_id: id,
          code: code,
          base_url: @base_uri
        )
      end
    end
  end
end
