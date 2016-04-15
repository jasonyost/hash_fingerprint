require 'hash_fingerprint/version'
require 'digest/sha2'

module HashFingerprint
    # Public: Returns string representation of object
    #
    # object  - A hash, or array
    #
    # Examples
    #  hash = {a: {b: 'b', c: 'c'} d: 'd'}
    #  HashFingerprint.get_object_string(object)
    #  => "[\"[\\\"b=>b\\\", \\\"c=>c\\\"]Array=>[\\\"b=>b\\\", \\\"c=>c\\\"]Array\", \"d=>d\"]Array"
    #
    # Returns string
    def self.get_object_string(object)
        parse(object).tap { |obj| return obj.class == String ? obj : to_string(obj) }
    end

    # Public: Returns SHA256 fingerprint of object
    #
    # object  - A hash, or array
    #
    # Examples
    #  hash = {a: {b: 'b', c: 'c'} d: 'd'}
    #  HashFingerprint.fingerprint(object)
    #  => "95045071ee6ce0333d7cd6408962b64a7520d45e0be6161ecd666a30bf7f3706"
    #
    # Returns string
    def self.fingerprint(object)
      Digest::SHA256.hexdigest get_object_string object
    end

    # Public: Returns true/false if objects match
    #
    # left_object  - A hash, or array
    # right_object  - A hash, or array
    #
    # Examples
    #  ordered_hash = {a: {b: 'b', c: 'c'} d: 'd'}
    #  unordered_hash = {:d => 'd', :a => {:c => 'c', :b => 'b'}}
    #  HashFingerprint.compare(left_object, right_object)
    #  => true
    #
    # Returns bool
    def self.compare(left_object, right_object)
      fingerprint(left_object) == fingerprint(right_object)
    end

    private

    def self.parse(object)
        case object
        when Hash
            parse_hash object
        when Array
            parse_array object
        when String
            object
        else
            to_string(object)
        end
    end

    def self.hash_string_array(hash)
      [].tap do |a|
        hash.each { |k,v| a << pair_string(k,v) }
      end
    end

    def self.pair_string(k, v)
      "#{get_object_string(v)}=>#{get_object_string(v)}"
    end

    def self.parse_hash(hash)
      get_object_string hash_string_array(hash)
    end

    def self.parse_array(arr)
      arr.map! { |i| get_object_string i }.sort!
    end

    def self.to_string(object)
      "#{object.to_s}#{object.class.to_s}"
    end
end
