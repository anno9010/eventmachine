require 'em_test_helper'

class TestBasic < Test::Unit::TestCase
  def test_a
    EM.run {
      d = EM::DNS::Resolver.resolve "google.com"
      d.errback { assert false }
      d.callback { |r|
        assert r
        EM.stop
      }
    }
  end

  def test_bad_host
    EM.run {
      d = EM::DNS::Resolver.resolve "asdfasasdf"
      d.callback { assert false }
      d.errback  { assert true; EM.stop }
    }
  end

  def test_garbage
    assert_raises( ArgumentError ) {
      EM.run {
        EM::DNS::Resolver.resolve 123
      }
    }
  end

  def test_a_pair
    EM.run {
      d = EM::DNS::Resolver.resolve "google.com"
      d.errback { assert false }
      d.callback { |r|
        assert_equal(Array, r.class)
        assert r.size > 1
        EM.stop
      }
    }
  end
end
