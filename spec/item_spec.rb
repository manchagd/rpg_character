# frozen_string_literal: true
require 'rspec'
require 'pry'
require_relative '../src/models/character.rb'

RSpec.describe Item do
  subject { Item.new(name: item_name, type: item_type, value: item_value) }

  describe 'attributes' do
    context 'when the item is armor' do
      let(:item_name) { 'armor-1' }
      let(:item_type) { 'armor' }
      let(:item_value) { 100 }

      describe '#name' do
        it { expect(subject.name).to eq(item_name) }
      end

      describe '#type' do
        it { expect(subject.type).to eq(Item::ARMOR) }
      end

      describe '#value' do
        it { expect(subject.value).to eq(item_value) }
      end
    end

    context 'when the item is weapon' do
      let(:item_name) { 'sword-1' }
      let(:item_type) { 'weapon' }
      let(:item_value) { 20 }

      describe '#name' do
        it { expect(subject.name).to eq(item_name) }
      end

      describe '#type' do
        it { expect(subject.type).to eq(Item::WEAPON) }
      end

      describe '#value' do
        it { expect(subject.value).to eq(item_value) }
      end
    end

    context 'when the item is weapon' do
      let(:item_name) { 'potion-1' }
      let(:item_type) { 'potion' }
      let(:item_value) { 10 }

      describe '#name' do
        it { expect(subject.name).to eq(item_name) }
      end

      describe '#type' do
        it { expect(subject.type).to eq(Item::POTION) }
      end

      describe '#value' do
        it { expect(subject.value).to eq(item_value) }
      end
    end

    context 'when the type is not armor or weapon' do
      let(:item_name) { 'other-1' }
      let(:item_type) { 'other' }
      let(:item_value) { 20 }

      describe '#name' do
        it { expect(subject.name).to eq('unknown') }
      end

      describe '#type' do
        it { expect(subject.type).to eq(Item::UNKNOWN) }
      end

      describe '#value' do
        it { expect(subject.value).to eq(0) }
      end
    end
  end

end
