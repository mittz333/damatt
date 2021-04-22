require 'rails_helper'

RSpec.describe Member, type: :model do
  describe '#create' do
    before do
      @member = FactoryBot.build(:member)
    end

    it "nameとemail、passwordとpassword_confirmation、department_id、が存在すれば登録できること" do
      expect(@member).to be_valid
    end

    it '名前が必須であること' do
      @member.name = nil
      @member.valid?
      expect(@member.errors.full_messages).to include("Nameを入力してください")
    end

    it 'メールアドレスが必須であること' do
      @member.email = nil
      @member.valid?
      expect(@member.errors.full_messages).to include("Emailを入力してください")
    end

    it 'メールアドレスが一意性であること' do
      @member.save
      another_member = FactoryBot.build(:member, email: @member.email)
      another_member.valid?
      expect(another_member.errors.full_messages).to include('Emailはすでに存在します')
    end

    it 'メールアドレスは、@を含む必要があること' do
      @member.email = @member.email.gsub(/@/, '_at_')
      @member.valid?
      expect(@member.errors.full_messages).to include('Emailは不正な値です')
    end

    it 'パスワードが必須であること' do
      @member.password = nil
      @member.valid?
      expect(@member.errors.full_messages).to include("Passwordを入力してください")
    end

    it 'パスワードは、6文字以上での入力が必須であること' do
      @member.password = '12345'
      @member.password_confirmation = '12345'
      @member.valid?
      expect(@member.errors.full_messages).to include('Passwordは6文字以上で入力してください')
    end

    # it 'パスワードは、半角英数字混合での入力が必須であること(数字のみ)' do
    #   @member.password = '123456'
    #   @member.password_confirmation = '123456'
    #   @member.valid?
    #   expect(@member.errors.full_messages).to include('Password には英字と数字の両方を含めて設定してください')
    # end

    # it 'パスワードは、半角英数字混合での入力が必須であること(英字のみ)' do
    #   @member.password = 'abcdef'
    #   @member.password_confirmation = 'abcdef'
    #   @member.valid?
    #   expect(@member.errors.full_messages).to include('Password には英字と数字の両方を含めて設定してください')
    # end

    # it 'パスワードは、半角英数字混合での入力が必須であること(全角では登録出来ないこと)' do
    #   @member.password = 'あいうえお１２３４５'
    #   @member.password_confirmation = 'あいうえお１２３４５'
    #   @member.valid?
    #   expect(@member.errors.full_messages).to include('Password には英字と数字の両方を含めて設定してください')
    # end

    it 'パスワードは、確認用を含めて2回入力すること' do
      @member.password_confirmation = ''
      @member.valid?
      expect(@member.errors.full_messages).to include("Password confirmationとPasswordの入力が一致しません")
    end

    it 'パスワードとパスワード（確認用）、値の一致が必須であること' do
      @member.password = 'a123456'
      @member.password_confirmation = 'a1234567'
      @member.valid?
      expect(@member.errors.full_messages).to include("Password confirmationとPasswordの入力が一致しません")
    end

    it '部門が必須であること' do
      @member.department_id = nil
      @member.valid?
      expect(@member.errors.full_messages).to include("Departmentを入力してください")
    end
  end
end
