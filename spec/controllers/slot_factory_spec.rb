describe SlotFactory, :type => :custom do
  YOU_SLOT = Slot.new(:you_pin)
  EPA_SLOT = Slot.new(:epa_pin)
  MATCH_SLOT = Slot.new(:match_pin)
  EMPTY_SLOT = Slot.new(:empty)

  describe '#for_grades' do
    subject { SlotFactory.new.for_grades(epa_grade, user_grade) }

    describe 'when the User and EPA score differently' do
      let(:epa_grade) { AirQualityGrade.new('F') }
      let(:user_grade) { AirQualityGrade.new('B') }
      it 'includes a :one_pin slot for each grade' do
        expect(subject[1]).to eq(YOU_SLOT)
        expect(subject[5]).to eq(EPA_SLOT)
      end

      it 'sets the remaining slots to be empty' do
        expect(subject[0]).to eq(EMPTY_SLOT)
        expect(subject[2]).to eq(EMPTY_SLOT)
        expect(subject[3]).to eq(EMPTY_SLOT)
        expect(subject[4]).to eq(EMPTY_SLOT)
      end

    end

    describe 'when the User and EPA score identically' do
      let(:epa_grade) { AirQualityGrade.new('A') }
      let(:user_grade) { AirQualityGrade.new('A') }
      it 'includes a :two_pin slot for that grade' do
        expect(subject[0]).to eq(MATCH_SLOT)
      end

      it 'sets the remaining slots to be empty' do
        expect(subject[1]).to eq(EMPTY_SLOT)
        expect(subject[2]).to eq(EMPTY_SLOT)
        expect(subject[3]).to eq(EMPTY_SLOT)
        expect(subject[4]).to eq(EMPTY_SLOT)
        expect(subject[5]).to eq(EMPTY_SLOT)
      end
    end
  end
end
