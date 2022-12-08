require "rspec"
require "pry"
require_relative "../src/models/character.rb"
require_relative "../src/models/inventory.rb"
require_relative "../src/models/item.rb"
require_relative "../src/models/ability.rb"

RSpec.describe Character do
  subject do
    Character.new(
      name: 'character-1',
      base_health: base_health,
      inventory: inventory,
      damage_abilities: damage_abilities,
      consumable_abilities: consumable_abilities
    )
  end
  let(:damage_abilities) { [damage_ability1, damage_ability2] }
  let(:consumable_abilities) { [consumible_ability1, consumible_ability2] }
  let(:base_health) { 100 }
  let(:inventory) { Inventory.new(size: 5, items: inventory_items) }
  let(:inventory_items) { [] }
  let(:damage_ability1) { Ability.new(type: Ability::ATTACK, multiplier: 1.2, item: weapon1) }
  let(:damage_ability2) { Ability.new(type: Ability::ATTACK, multiplier: 1.5, item: weapon2) }
  let(:consumible_ability1) { Ability.new(type: Ability::CONSUMIBLE, multiplier: 1.2, item: potion1) }
  let(:consumible_ability2) { Ability.new(type: Ability::CONSUMIBLE, multiplier: 1.1, item: armor2) }
  let(:weapon1) { Item.new(name: 'weapon-1', type: Item::WEAPON, value: 20) }
  let(:weapon2) { Item.new(name: 'weapon-2', type: Item::WEAPON, value: 10) }
  let(:potion1) { Item.new(name: 'potion-1', type: Item::POTION, value: 20) }
  let(:armor2) { Item.new(name: 'armor-1', type: Item::ARMOR, value: 100) }

  describe 'attributes' do
    describe '#name' do
      it { expect(subject.name).to eq('character-1') }
    end

    describe '#base_healt' do
      it { expect(subject.base_healt).to eq(base_health) }
    end

    describe '#inventory' do
      it { expect(subject.inventory).to be_instance_of(Inventory) }
    end

    describe '#damage_abilities' do
      it { expect(subject.damage_abilities).to be_instance_of(Array) }
    end

    describe '#consumable_abilities' do
      it { expect(subject.consumable_abilities).to be_instance_of(Array) }
    end
  end

  describe '#attack' do
  end

  describe '#consume' do
  end

end
