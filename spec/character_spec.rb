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
  let(:armor2) { Item.new(name: 'armor-2', type: Item::ARMOR, value: 100) }

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
      it do
        expect(subject.damage_abilities).to be_instance_of(Array)
        subject.damage_abilities.each do |ability|
          expect(ability).to be_instance_of(Ability)
          expect(ability.type).to eq(Ability::ATTACK)
        end
      end
    end

    describe '#consumable_abilities' do
      it do
        expect(subject.consumable_abilities).to be_instance_of(Array)
        subject.consumable_abilities.each do |ability|
          expect(ability).to be_instance_of(Ability)
          expect(ability.type).to eq(Ability::CONSUMIBLE)
          end
      end
    end
  end

  describe '#attack' do
    let(:attack) { subject.attack(action) }

    context 'when is action 1' do
      let(:action) { 1 }
      let(:action_response) do
        {
          value: 24.0,
          type: 'damage',
          target: 'enemy',
        }
      end

      it 'perform damage_ability 1' do
        expect(attack).to include_json(action_response)
      end
    end

    context 'when is action 2' do
      let(:action) { 2 }
      let(:action_response) do
        {
          value: 15,
          type: 'damage',
          target: 'enemy',
        }
      end

      it 'perform damage_ability 2' do
        expect(attack).to include_json(action_response)
      end
    end
  end

  describe '#consume' do
    let(:consume) { subject.consume(action) }

    context 'when is action 1' do
      let(:action) { 1 }
      let(:action_response) do
        {
          value: 24.0,
          type: 'heal',
          target: 'self'
        }
      end

      it 'perform damage_ability 1' do
        expect(consume).to include_json(action_response)
      end
    end

    context 'when is action 2' do
      let(:action) { 2 }
      let(:action_response) do
        {
          value: 110,
          type: 'armor',
          target: 'self'
        }
      end

      it 'perform damage_ability 2' do
        expect(consume).to include_json(action_response)
      end
    end
  end

  describe '#effects_queue' do
  end

end
