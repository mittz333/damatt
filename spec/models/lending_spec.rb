require 'rails_helper'

RSpec.describe Lending, type: :model do
  describe '#create' do
    before do
      member = FactoryBot.create(:member)
      item = FactoryBot.create(:item)
      @lending = FactoryBot.build(:lending, member_id: member.id, item_id: item.id)
      sleep 0.1
    end

    it "category_idとlocation_id、departmentが存在すれば登録できること" do
      expect(@lending).to be_valid
    end

    it 'memberが必須であること(nullではない)' do
      @lending.member_id = nil
      @lending.valid?
      expect(@lending.errors.full_messages).to include('Memberを入力してください')
    end

    it 'itemが必須であること(nullではない)' do
      @lending.item_id = nil
      @lending.valid?
      expect(@lending.errors.full_messages).to include('Itemを入力してください')
    end

  end
end
