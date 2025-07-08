# frozen_string_literal: true

require "spec_helper"

RSpec.describe OmniAuth::Strategies::Smaregi do
  let(:custom_options) { {} }
  subject do
    described_class.new(nil, custom_options)
  end

  before { subject.setup_phase }

  describe "Client options" do
    context "when sandbox option true" do
      let(:custom_options) { { sandbox: true } }
      let(:options) { subject.options.client_options }

      it "has correct site" do
        expect(options.site).to eq "https://id.smaregi.dev"
      end

      it "has correct authorize url" do
        expect(options.authorize_url).to eq "https://id.smaregi.dev/authorize"
      end

      it "has correct token url" do
        expect(options.token_url).to eq "https://id.smaregi.dev/authorize/token"
      end
    end

    context "when sandbox option false" do
      let(:custom_options) { { sandbox: false } }
      let(:options) { subject.options.client_options }

      it "has correct site" do
        expect(options.site).to eq "https://id.smaregi.jp"
      end

      it "has correct authorize url" do
        expect(options.authorize_url).to eq "https://id.smaregi.jp/authorize"
      end

      it "has correct token url" do
        expect(options.token_url).to eq "https://id.smaregi.jp/authorize/token"
      end
    end
  end

  describe "callback_url" do
    it "has the collect callback url" do
      allow(subject).to receive(:full_host).and_return("https://example.com")
      allow(subject).to receive(:script_name).and_return("/sub_uri")
      allow(subject).to receive(:callback_path).and_return("/callback")

      expect(subject.callback_url).to eq("https://example.com/sub_uri/callback")
    end
  end

  describe "raw_info" do
    let(:access_token) { instance_double("AccessToken", options: {}) }
    let(:parsed_response) { instance_double("ParsedResponse") }
    let(:response) { instance_double("Response", parsed: parsed_response) }

    it "uses relative paths" do
      allow(subject).to receive(:access_token).and_return(access_token)
      expect(access_token).to receive(:get).with("/userinfo").and_return(response)
      expect(subject.raw_info).to eq(parsed_response)
    end
  end

  describe "fail!" do
    before do
      allow(subject).to receive(:request).and_return(double(params: { "error" => "access_denied" }))
    end

    context "when :fail_path option is present" do
      let(:custom_options) { { fail_path: "integrations/smaregi" } }

      it "redirects to fail_path" do
        expect(subject).to receive(:redirect).with("integrations/smaregi")
        subject.callback_phase
      end
    end

    context "when :fail_path option is not present" do
      it "redirects to default path" do
        expect(subject).to receive(:redirect).with("")
        subject.callback_phase
      end
    end
  end
end
