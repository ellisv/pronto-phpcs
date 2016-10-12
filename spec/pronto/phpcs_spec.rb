require 'spec_helper'

module Pronto
  describe Phpcs do
    let(:phpcs) { Phpcs.new(patches) }
    let(:patches) { nil }

    describe '#run' do
      subject(:run) { phpcs.run }

      context 'patches are nil' do
        it { should == [] }
      end

      context 'no patches' do
        let(:patches) { [] }
        it { should == [] }
      end
    end
  end
end
