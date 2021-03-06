describe "==> DELETE" do
  context "Quando tenho usuario cadastrado" do
    let(:user) { build(:registered_user) }
    let(:token) { ApiUser.token(user.email, user.password) }
    let(:result) { ApiUser.remove(token, user.id) }

    it { expect(result.response.code).to eql "204" }
  end

  context "Quando não existe usuario" do
    let(:user) { build(:registered_user) }
    let(:token) { ApiUser.token(user.email, user.password) }
    let(:result) { ApiUser.remove(token, "0") }

    it { expect(result.response.code).to eql "404" }
  end

  context "Quando ID errado" do
    let(:user) { build(:registered_user) }
    let(:token) { ApiUser.token(user.email, user.password) }
    let(:result) { ApiUser.remove(token, "abc123") }

    it { expect(result.response.code).to eql "412" }
  end
end
