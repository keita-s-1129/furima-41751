require 'rails_helper'

RSpec.describe OrderForm, type: :model do
  before do
    @user = FactoryBot.create(:user)
    @item = FactoryBot.create(:item)
    @order_form = FactoryBot.build(:order_form, user_id: @user.id, item_id: @item.id)
    sleep(0.5)
  end
  describe '商品購入' do
    context '商品購入できるとき' do
      it 'post_code,prefecture_id,city,address,phone_numberが入力されているとき' do
        expect(@order_form).to be_valid
      end
      it 'building_nameが空でも購入できること' do
        @order_form.building_name = ''
        expect(@order_form).to be_valid
      end
    end
    context '商品購入できないとき' do
      it 'post_codeが空では出品できない' do
        @order_form.post_code = ''
        @order_form.valid?
        expect(@order_form.errors.full_messages).to include "Post code can't be blank"
      end
      it 'prefecture_idが1では出品できない' do
        @order_form.prefecture_id = 1
        @order_form.valid?
        expect(@order_form.errors.full_messages).to include "Prefecture can't be blank"
      end
      it 'cityが空では出品できない' do
        @order_form.city = ''
        @order_form.valid?
        expect(@order_form.errors.full_messages).to include "City can't be blank"
      end
      it 'addressが空では出品できない' do
        @order_form.address = ''
        @order_form.valid?
        expect(@order_form.errors.full_messages).to include "Address can't be blank"
      end
      it 'phone_numberが空では出品できない' do
        @order_form.phone_number = ''
        @order_form.valid?
        expect(@order_form.errors.full_messages).to include "Phone number can't be blank"
      end
      it 'phone_numberが10桁以下だと購入できない' do
        @order_form.phone_number = '123456789'
        @order_form.valid?
        expect(@order_form.errors.full_messages).to include('Phone number must be 10 or 11 digits long')
      end
      it 'phone_numberが12桁以上だと購入できない' do
        @order_form.phone_number = '123456789012'
        @order_form.valid?
        expect(@order_form.errors.full_messages).to include('Phone number must be 10 or 11 digits long')
      end
      it 'phone_numberが半角数字でないと購入できない' do
        @order_form.phone_number = '０９０12345678'
        @order_form.valid?
        expect(@order_form.errors.full_messages).to include('Phone number must be 10 or 11 digits long')
      end
      it 'tokenが空では購入できない' do
        @order_form.token = nil
        @order_form.valid?
        expect(@order_form.errors.full_messages).to include("Token can't be blank")
      end
      it 'user_idが紐づいていなければ購入できない' do
        @order_form.user_id = ''
        @order_form.valid?
        expect(@order_form.errors.full_messages).to include("User can't be blank")
      end
      it 'item_idが紐づいていなければ購入できない' do
        @order_form.item_id = ''
        @order_form.valid?
        expect(@order_form.errors.full_messages).to include("Item can't be blank")
      end
    end
  end
end
