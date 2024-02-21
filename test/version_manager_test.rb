# frozen_string_literal: true

require 'minitest/autorun'
require '../lib/version_manager'

# Test for VersionManager class
class VersionManagerTest < Minitest::Test
  def setup
    version_manager = VersionManager.new
    @next_version = version_manager.method(:nextVersion)
  end

  def test_version_with_single_segment
    assert_equal @next_version.call('10'), '11'
  end

  def test_version_with_two_segments_minor_version_is_nine
    assert_equal @next_version.call('10.9'), '11.0'
  end

  def test_version_with_two_segments_only_nines
    assert_equal @next_version.call('9.9'), '10.0'
  end

  def test_version_with_three_segments_but_no_nines
    assert_equal @next_version.call('1.2.3'), '1.2.4'
  end

  def test_version_with_three_segments_patch_version_less_than_nine
    assert_equal @next_version.call('10.9.3'), '10.9.4'
  end

  def test_version_with_three_segments_two_nines_sequence
    assert_equal @next_version.call('0.9.9'), '1.0.0'
  end

  def test_version_with_six_segments_multiple_nine_sequence_from_the_last_segment
    assert_equal @next_version.call('10.9.0.9.9.9'), '10.9.1.0.0.0'
  end

  def test_version_with_eight_segments_crescent_sequence_no_nines
    assert_equal @next_version.call('1.2.3.4.5.6.7.8'), '1.2.3.4.5.6.7.9'
  end
end
