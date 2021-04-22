require 'rails_helper'

RSpec.describe Item, type: :model do
  describe '#create' do
    before do
      @item = FactoryBot.build(:item)
    end

    it "category_idとlocation_id、departmentが存在すれば登録できること" do
      expect(@item).to be_valid
    end

    it 'カテゴリーが必須であること(0ではない)' do
      @item.category_id = 0
      @item.valid?
      expect(@item.errors.full_messages).to include('Categoryは10より大きい値にしてください')
    end

    it 'ロケーションが必須であること(0ではない)' do
      @item.location_id = 0
      @item.valid?
      expect(@item.errors.full_messages).to include('Locationは0以外の値にしてください')
    end

    it '部門が必須であること(0ではない)' do
      @item.department_id = 0
      @item.valid?
      expect(@item.errors.full_messages).to include('Departmentは0以外の値にしてください')
    end

    # it '画像が必須であること' do
    #   @item.image = nil
    #   @item.valid?
    #   expect(@item.errors.full_messages).to include("Image can't be blank")
    # end

    # it 'ユーザーが必須であること' do
    #   @item.user = nil
    #   @item.valid?
    #   expect(@item.errors.full_messages).to include('User must exist')
    # end
  end
end
