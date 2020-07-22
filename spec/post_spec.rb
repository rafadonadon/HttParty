describe "==> POST" do
  context "Quando cadastro um novo usuario" do
    # before do
    #   @new_user = build(:user).to_hash
    #   puts "ADD o email " + @new_user[:email]
    #   @result = ApiUser.save(@new_user)
    # end

    let(:result) { ApiUser.save(build(:user).to_hash) }
    it { expect(result.response.code).to eql "200" }
  end

  context "Quando email for Duplicado" do
    # before do
    #   @new_user = build(:registered_user).to_hash
    #   @result = ApiUser.save(@new_user)
    # end

    let(:result) { ApiUser.save(build(:registered_user).to_hash) }
    it { expect(result.response.code).to eql "409" }
    it { expect(result.parsed_response["msg"]).to eql "Oops. Looks like you already have an account with this email address." }
  end

  context "Quando email estiver Invalido" do
    # before do
    #   @new_user = build(:user_wrong_email).to_hash
    #   @result = ApiUser.save(@new_user)
    # end

    let(:result) { ApiUser.save(build(:user_wrong_email).to_hash) }
    it { expect(result.response.code).to eql "412" }
    it { expect(result.parsed_response["msg"]).to eql "Oops. You entered a wrong email." }
  end

  context "Quando nome estiver vazio" do
    # before do
    #   @new_user = build(:empty_name_user).to_hash
    #   @result = ApiUser.save(@new_user)
    # end

    let(:result) { ApiUser.save(build(:empty_name_user).to_hash) }
    it { expect(result.response.code).to eql "412" }
    it { expect(result.parsed_response["msg"]).to eql "Validation notEmpty on full_name failed" }
  end

  context "Quando email estiver vazio" do
    # before do
    #   @new_user = build(:empty_email_user).to_hash
    #   @result = ApiUser.save(@new_user)
    # end

    let(:result) { ApiUser.save(build(:empty_email_user).to_hash) }
    it { expect(result.response.code).to eql "412" }
    it { expect(result.parsed_response["msg"]).to eql "Validation notEmpty on email failed" }
  end

  context "Quando senha estiver vazio" do
    # before do
    #   @new_user = build(:empty_password_user).to_hash
    #   @result = ApiUser.save(@new_user)
    # end

    let(:result) { ApiUser.save(build(:empty_password_user).to_hash) }
    it { expect(result.response.code).to eql "412" }
    it { expect(result.parsed_response["msg"]).to eql "Validation notEmpty on password failed" }
  end

  context "Quando nome estiver NULO" do
    # before do
    #   @new_user = build(:null_name_user).to_hash
    #   @result = ApiUser.save(@new_user)
    # end

    let(:result) { ApiUser.save(build(:null_name_user).to_hash) }
    it { expect(result.response.code).to eql "412" }
    it { expect(result.parsed_response["msg"]).to eql "Users.full_name cannot be null" }
  end

  context "Quando email estiver NULO" do
    # before do
    #   @new_user = build(:null_email_user).to_hash
    #   @result = ApiUser.save(@new_user)
    # end

    let(:result) { ApiUser.save(build(:null_email_user).to_hash) }
    it { expect(result.response.code).to eql "412" }
    it { expect(result.parsed_response["msg"]).to eql "Users.email cannot be null" }
  end

  context "Quando senha estiver NULO" do
    # before do
    #   @new_user = build(:null_password_user).to_hash
    #   @result = ApiUser.save(@new_user)
    # end

    let(:result) { ApiUser.save(build(:null_password_user).to_hash) }
    it { expect(result.response.code).to eql "412" }
    it { expect(result.parsed_response["msg"]).to eql "Users.password cannot be null" }
  end
end
