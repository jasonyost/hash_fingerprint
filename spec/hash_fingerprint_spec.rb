require 'simplecov'
SimpleCov.start
require 'spec_helper'

describe HashFingerprint do
  let(:ordered_hash) { { a: { b: 'b', c: 'c' }, d: 'd', e: { f: 1, g: 2 } } }
  let(:unordered_hash) { { d: 'd', a: { c: 'c', b: 'b' }, e: { g: 2, f: 1 } } }
  let(:ordered_array) { [1, 2, 3, [4, [5, 6]], %w(a b c)] }
  let(:unordered_array) { [%w(c b a), 3, 2, 1, [[5, 6], 4]] }

  it 'has a version number' do
      expect(HashFingerprint::VERSION).not_to be nil
  end

  describe '.get_object_string(object)' do
    context 'given a valid argument' do
        it 'should not raise an error' do
            expect { subject.get_object_string(ordered_hash) }.not_to raise_error
        end
    end

    context 'given a Hash' do
        it 'should return a string of the hash' do
            expect(subject.get_object_string ordered_hash).to be_a String
        end

        it 'should return equal strings regardless of order' do
            expect(subject.get_object_string ordered_hash).to eq(subject.get_object_string unordered_hash)
        end
    end

    context 'given an array' do
        it 'should should return a string of the array' do
            expect(subject.get_object_string ordered_array).to be_a String
        end

        it 'should return equal strings regardless of order' do
            expect(subject.get_object_string ordered_array).to eq(subject.get_object_string unordered_array)
        end
    end
  end

  describe '.fingerprint(object)' do
    context 'given a valid argument' do
        it 'should not raise an error' do
            expect { subject.fingerprint ordered_hash }.not_to raise_error
        end

        context 'given a hash' do
            it 'should return a string' do
                expect(subject.fingerprint ordered_hash).to be_a String
            end

            it 'should return an SHA256 fingerprint' do
                expect(subject.fingerprint ordered_hash).to eq(Digest::SHA256.hexdigest subject.get_object_string ordered_hash)
            end

            it 'should return equal fingerprints regardless of order' do
                expect(subject.fingerprint ordered_hash).to eq(subject.fingerprint unordered_hash)
            end
        end

        context 'given a array' do
            it 'should return a string' do
                expect(subject.fingerprint ordered_array).to be_a String
            end

            it 'should return an SHA256 fingerprint' do
                expect(subject.fingerprint ordered_array).to eq(Digest::SHA256.hexdigest subject.get_object_string ordered_array)
            end

            it 'should return equal fingerprints regardless of order' do
                expect(subject.fingerprint ordered_array).to eq(subject.fingerprint unordered_array)
            end
        end
    end
  end

  describe '.compare' do
    context 'given valid arguments' do
      it 'should not raise an error' do
        expect { subject.compare ordered_hash, unordered_hash }.not_to raise_error
      end

      context 'given matching hashes with with differing orders' do
        it 'should return true' do
          expect(subject.compare ordered_hash, unordered_hash).to eq true
        end
      end

      context 'given differing hashes' do
        it 'should return false' do
          hash = { a: 'a', b: 'b' }
          expect(subject.compare hash, ordered_hash).to eq false
        end
      end

      context 'given matching arrays with with differing orders' do
        it 'should return true' do
          expect(subject.compare ordered_array, unordered_array).to eq true
        end
      end

      context 'given differing hashes' do
        it 'should return false' do
          array = [5, 11, 'a', :b]
          expect(subject.compare array, ordered_array).to eq false
        end
      end
    end
  end
end
