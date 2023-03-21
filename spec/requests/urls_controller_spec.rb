require 'rails_helper'

RSpec.describe UrlsController, type: :request do
    describe 'post long url' do
      subject { post "/api/v1/shorten", params: { longUrl: "helloworld.com" } }

      it 'should create url record and generate short url' do
        expect { subject }.to change { Url.where(long_url: "helloworld.com").count }.by(1)
        expect(response.status).to eq(201)
        expect(JSON.parse(response.body)).to match( {"short_url"=> be_a(String) } ) 
      end
    end

    describe 'get short url' do
      subject { get "/#{url.short_url}"}

      let!(:url) do
        url = Url.create!(long_url: "howdy.com")
        url.generate_short_url
        url
      end

      it "should redirect to the long_url" do
        subject
        expect(response.status).to eq(301)
        expect(response).to redirect_to(url.long_url)
      end
    end
end