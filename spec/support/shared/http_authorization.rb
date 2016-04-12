shared_examples_for "HTTP Authenticable" do
  context 'unauthorized' do
    let(:http_method) { 'get' }

    it 'returns redirected status if user not authorized' do
      do_request(http_path, http_method)
      expect(response).to have_http_status(:redirect)
    end
  end
end

