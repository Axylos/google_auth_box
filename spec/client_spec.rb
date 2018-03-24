RSpec.describe GoogleAuthBox do
  describe GoogleAuthBox::Client do
    let(:file_path) { './auth_client_test.yml' }
    before do
      File.delete file_path if File.exist? file_path
      f = File.open file_path, 'w'
      f.close
    end

    # after { File.delete file_path if File.exist? file_path }
    #
    let(:client_id) { 
      JSON.parse('{"web":
        {
          "client_id": "abc@example.com",
          "project_id": "imunique",
          "auth_uri": "https://accounts.google.com/o/oauth2/auth",
          "token_uri": "https://accounts.google.com/o/oauth2/token",
          "auth_provider_x509_cert_url": "https://www.googleapis.com/oauth2/v1/certs",
          "client_secret": "waynotsecret", 
          "redirect_uris": ["apath"],
          "javascript_origins": ["anorigin"]
        }
      }')
    }

    let :base_uri { 'http://mybaseuri.com' }
    let(:client) { GoogleAuthBox::Client.new(
      client_id_hash: client_id,
      scopes: ["sheets"], 
      data_file_path: file_path,
      base_uri: base_uri
    ) }

    describe "#get_creds" do
      let(:ex_uri) { 'abc@example.com' }
      let(:creds) do
        creds = double('creds')
        allow(creds).to receive(:client_id).and_return(ex_uri)
        allow(creds).to receive(:access_token)
        allow(creds).to receive(:refresh_token)
        allow(creds).to receive(:scope).and_return('https://www.googleapis.com/auth/spreadsheets  ')
        allow(creds).to receive(:expires_at)

        creds
      end
    end

    describe "#get_auth_url" do
      subject { client.get_auth_url }
      it { is_expected.to be_truthy }
      it { is_expected.to match base_uri }
    end
  end
end

