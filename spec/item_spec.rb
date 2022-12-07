# frozen_string_literal: true
require "rspec"
require "pry"
require_relative "../src/models/character.rb"

RSpec.describe Item do
  subject { Item.new(name: item_name, type: item_type, value: item_value) }

  describe 'attributes' do
    context 'when the item is armor' do
      let(:item_name) { "Armor-1" }
      let(:item_type) { "armor" }
      let(:item_value) { 100 }

      describe '#name' do
        expect(subject.name).to eq(item_name)
      end

      describe '#type' do
        expect(subject.type).to eq(ITEM::ARMOR)
      end

      describe '#value' do
        expect(subject.value).to eq(item_value)
      end
    end

    context 'when the item is weapon' do
      let(:item_name) { "Sword-1" }
      let(:item_type) { "weapon" }
      let(:item_value) { 20 }

      describe '#name' do
        it { expect(subject.name).to eq(item_name) }
      end

      describe '#type' do
        it { expect(subject.type).to eq(ITEM::WEAPON) }
      end

      describe '#value' do
        it { expect(subject.value).to eq(item_value) }
      end
    end

    context 'when the item is weapon' do
      let(:item_name) { "Potion-1" }
      let(:item_type) { "potion" }
      let(:item_value) { 10 }
yo
      describe '#name' do
        it { expect(subject.name).to eq(item_name) }
      end

      describe '#type' do
        it { expect(subject.type).to eq(ITEM::POTION) }
      end

      describe '#value' do
        it { expect(subject.value).to eq(item_value) }
      end
    end

    context 'when the type is not armor or weapon' do
      let(:item_name) { "Other-1" }
      let(:item_type) { "other" }
      let(:item_value) { 20 }

      describe '#name' do
        it { expect(subject.name).to eq("unknown") }
      end

      describe '#type' do
        it { expect(subject.type).to eq(ITEM::UNKNOWN) }
      end

      describe '#value' do
        it { expect(subject.value).to eq(0) }
      end
    end
  end

end
