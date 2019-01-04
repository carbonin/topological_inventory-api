RSpec.describe Api::V0x0::AuthenticationsController, :type => :request do
  it("Uses DestroyMixin") { expect(described_class.instance_method(:destroy).owner).to eq(Api::Mixins::DestroyMixin) }
  it("Uses IndexMixin")   { expect(described_class.instance_method(:index).owner).to eq(Api::Mixins::IndexMixin) }
  it("Uses ShowMixin")    { expect(described_class.instance_method(:show).owner).to eq(Api::Mixins::ShowMixin) }
  it("Uses UpdateMixin")  { expect(described_class.instance_method(:update).owner).to eq(Api::Mixins::UpdateMixin) }

  let(:endpoint)    { Endpoint.create!(:source => source, :tenant => tenant) }
  let(:source)      { Source.create!(:source_type => source_type, :tenant => tenant, :uid => SecureRandom.uuid) }
  let(:source_type) { SourceType.create!(:name => "openshift", :product_name => "OpenShift", :vendor => "Red Hat") }
  let(:tenant)      { Tenant.create! }

  it "post /authentications creates an Authentication" do
    headers = { "CONTENT_TYPE" => "application/json" }
    post(api_v0x0_authentications_url, :params => {:tenant_id => tenant.id.to_s, :resource_type => "Endpoint", :resource_id => endpoint.id, :name => "abc", :userid => "aaa", :password => "xxx"}.to_json)

    authentication = Authentication.first

    expect(response.status).to eq(201)
    expect(response.location).to match(a_string_ending_with("v0.0/authentications/#{authentication.id}"))
    expect(response.parsed_body).to eq(
      "id"            => authentication.id.to_s,
      "name"          => "abc",
      "resource_id"   => endpoint.id.to_s,
      "resource_type" => "Endpoint",
      "tenant_id"     => tenant.id.to_s,
      "userid"        => "aaa",
    )
  end
end