require "rspec"
require "pry"
require_relative "../src/models/equipment.rb"
require_relative "../src/models/item.rb"

RSpec.describe Equipment do
  subject { Equipment.new(size: equipment_size, items: equipment_items) }
  let(:equipment_size) { 10 }
  let(:equipment_items) { [] }

  describe 'attributes' do
    describe '#size' do
      it { expect(subject.size).to eq(equipment_size) }
    end
  end

  describe '#available_slots?' do
    let(:equipment_size) { 1 }

    context 'when is full' do
      let(:equipment_items) { [Item.new(name: 'potion-1', type: Item::POTION, value: 20)] }

      it 'returns false' do
        expect(subject.available_slots?).to be_falsey
      end
    end

    context 'when has slots' do
      it 'returns true' do
        expect(subject.available_slots?).to be_truthy
      end
    end
  end

  describe '#store' do
    let(:equipment_size) { 1 }
    let(:item1) { Item.new(name: 'potion-1', type: Item::POTION, value: 20) }
    let(:item2) { Item.new(name: 'potion-2', type: Item::POTION, value: 20) }

    context 'when is full' do
      let(:equipment_items) { [item1] }

      it 'returns nil' do
        expect(subject.store(item2)).to be_nil
      end

      it 'dont overflow equipment size' do
        subject.store(item2)
        expect(subject.size).to eq(1)
      end
    end

    context 'when has slots' do
      it 'returns the item' do
        expect(subject.store(item2)).to eq(item2)
      end

      it 'fulfill equipment' do
        subject.store(item2)
        expect(subject.size).to eq(1)
        expect(subject.available_slots?).to be_falsey
      end
    end
  end

  describe '#pick' do
    let(:equipment_size) { 2 }
    let(:item1) { Item.new(name: 'potion-1', type: Item::POTION, value: 20) }
    let(:item2) { Item.new(name: 'potion-2', type: Item::POTION, value: 20) }

    context 'when is full' do
      let(:equipment_items) { [item1, item2] }

      it 'free one slot' do
        subject.pick(1)
        expect(subject.available_slots?).to be_truthy
      end

      it 'extract and return the first item when pick(1)' do
        expect(subject.pick(1)).to eq(item1)
      end
    end

    context 'when is empty' do
      it 'returns nil' do
        expect(subject.pick(1)).to be_nil
      end
    end
  end

  describe '#open' do
    let(:equipment_size) { 4 }
    let(:item1) { Item.new(name: 'potion-1', type: Item::POTION, value: 20) }
    let(:item2) { Item.new(name: 'potion-2', type: Item::POTION, value: 20) }
    let(:equipment_items) { [item1, item2, nil, nil] }

    it 'shows [item1, nil, nil, nil] after pick(2) ' do
      subject.pick(2)
      expect(subject.open).to match_array([item1, nil, nil, nil])
    end
  end

end
