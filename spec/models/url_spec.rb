require 'rails_helper'

RSpec.describe Url, type: :model do
    let(:url) { Url.new(long_url: "helloworld.com") }

    describe 'generate_short_url' do
        subject { url.generate_short_url }

        it 'should generate a 7 character short id' do
           is_expected.to be_a(String)
           expect(subject.length).to be(7)
        end

        context 'there is a collision' do
          let!(:existing_url) do
            url.generate_short_url
            url.save!
            url
          end

          let!(:new_url) do
            Url.create!(long_url: "helloworld.com")
          end

          before do
            allow(Digest::MD5).to receive(:hexdigest).and_call_original
            allow(Digest::MD5).to receive(:hexdigest).with(new_url.id).and_return(existing_url.id)
          end

          it 'should resolve the collision and generate a different url' do
            url = Url.create!(long_url: "helloworld.com")
            url.generate_short_url
            expect(url.short_url).not_to eq(existing_url.short_url)
          end
        end
    end
end