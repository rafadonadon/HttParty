describe "==> GET" do
  context "Quando um usuario eh registrado" do
    let(:user) { build(:registered_user) }
    let(:token) { ApiUser.token(user.email, user.password) }
    let(:result) { ApiUser.find(token, user.id) }
    let(:user_data) { Database.new.find_user(user.email) }

    it { expect(result.response.code).to eql "200" }
    ##it { expect(result.parsed_response["full_name"]).to eql user.full_name } ##28:07
    it { expect(result.parsed_response["full_name"]).to eql user_data["full_name"] } ## dessa forma garante tbm a gravacao no BD
    it { expect(result.parsed_response["password"]).to eql user_data["password"] }
    it { expect(result.parsed_response["email"]).to eql user_data["email"] }

    ## problema com padroes "snake_case" e "camelCase" nas datas
    it { expect(Time.parse(result.parsed_response["createdAt"])).to eql Time.parse(user_data["created_at"]) }
    it { expect(Time.parse(result.parsed_response["updatedAt"])).to eql Time.parse(user_data["updated_at"]) }
  end

  context "Quando não existe usuario" do
    let(:user) { build(:registered_user) }
    let(:token) { ApiUser.token(user.email, user.password) }
    let(:result) { ApiUser.find(token, "0") }

    it { expect(result.response.code).to eql "404" }
  end

  context "Quando ID errado" do
    let(:user) { build(:registered_user) }
    let(:token) { ApiUser.token(user.email, user.password) }
    let(:result) { ApiUser.find(token, "abc123") }

    it { expect(result.response.code).to eql "412" }
  end

  context "Quando Outro ID" do
    let(:user) { build(:registered_user) }
    let(:other_user) { build(:registered_user) }
    let(:token) { ApiUser.token(user.email, user.password) }
    let(:result) { ApiUser.find(token, other_user.id) }

    it { expect(result.response.code).to eql "401" }
  end
end
