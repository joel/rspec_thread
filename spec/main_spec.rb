require 'spec_helper'

describe 'Sample' do
  subject { Main.new(verbose = false) }
  context 'inline' do
    let(:async) { false }
    before { subject.start async }
    it 'should keep order' do
      subject.result.should eql ['foo', 'bar', 'zone']
    end
  end
  context 'async' do
    let(:async) { true }
    before { subject.start async }
    it 'should reverse order' do
      subject.result.should eql ['zone', 'bar', 'foo']
    end
  end
end