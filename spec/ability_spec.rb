# frozen_string_literal: true
require "rspec"
require "pry"
require_relative "../src/models/ability.rb"
require_relative "../src/models/item.rb"

RSpec.describe Ability do
  subject { Ability.new(type: ability_type, multiplier: ability_multiplier, item: ability_item) }

  describe '#perform' do
    context 'when is attack' do
      let(:ability_type) { 'attack' }
      let(:ability_multiplier) { 1.2 }

      context 'and no weapon is provided' do
        let(:failed_weapon_perform) do
          {
            value: 0.0,
            type: 'failed',
            target: 'enemy'
          }
        end

        context 'and nothing is provided' do
          let(:ability_item) { nil }

          it 'failed' do
            expect(subject.perform).to include_json(failed_weapon_perform)
          end
        end

        context 'and a potion is provided' do
          let(:ability_item) { Item.new(name: 'potion-1', type: Item::POTION, value: 20) }

          it 'failed' do
            expect(subject.perform).to include_json(failed_weapon_perform)
          end
        end

        context 'and an armor is provided' do
          let(:ability_item) { Item.new(name: 'armor-1', type: Item::ARMOR, value: 120) }

          it 'failed' do
            expect(subject.perform).to include_json(failed_weapon_perform)
          end
        end
      end

      context 'and a weapon is provided' do
        let(:ability_item) { Item.new(name: 'sword-1', type: Item::WEAPON, value: 20) }
        let(:success_weapon_perform) do
          {
            value: 24.0,
            type: 'damage',
            target: 'enemy'
          }
        end

        it 'causes 24 damage' do
          expect(subject.perform).to include_json(success_weapon_perform)
        end
      end
    end

    context 'when is consumible object' do
      let(:ability_type) { 'consumible' }
      let(:ability_multiplier) { 1.2 }

      context 'and no consumible object is provided' do
        let(:failed_consumible_perform) do
          {
            value: 0.0,
            type: 'failed',
            target: 'self'
          }
        end

        context 'and nothing is provided' do
          let(:ability_item) { nil }

          it 'failed' do
            expect(subject.perform).to include_json(failed_consumible_perform)
          end
        end

        context 'and a weapon is provided' do
          let(:ability_item) { Item.new(name: 'weapon-1', type: Item::WEAPON, value: 20) }

          it 'failed' do
            expect(subject.perform).to include_json(failed_consumible_perform)
          end
        end
      end

      context 'and a consumible object is provided' do
        context 'and an armor is provided' do
          let(:ability_item) { Item.new(name: 'armor-1', type: Item::ARMOR, value: 100) }
          let(:success_consumible_perform) do
            {
              value: 120,
              type: 'armor',
              target: 'self'
            }
          end

          it 'increase armor by 120' do
            expect(subject.perform).to include_json(success_consumible_perform)
          end
        end

        context 'and a potion is provided' do
          let(:ability_item) { Item.new(name: 'potion-1', type: Item::POTION, value: 20) }
          let(:success_consumible_perform) do
            {
              value: 24.0,
              type: 'heal',
              target: 'self'
            }
          end

          it 'heals 24 life points' do
            expect(subject.perform).to include_json(success_consumible_perform)
          end
        end
      end
    end
  end

end
