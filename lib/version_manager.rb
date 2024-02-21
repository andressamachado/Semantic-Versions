# frozen_string_literal: true

# == Requirement ==
# No number but the first may be greater than 9
# if any are, you must set them to 0 and increment the next number in sequence.
class VersionManager
  # Function to get the next version to be installed
  def nextVersion(current_version)
    # reverse array to start process from the last segment
    version_segments = current_version.split('.').map(&:to_i).reverse
    process(version_segments)
  end

  private

  # Function to process the version segments
  def process(version_segments)
    version_segments.each_with_index do |segment, index|
      if segment == 9
        major_segment = version_segments.length - 1
        # -> major segment increase freely
        # if not the major segment:
        # we set current segment to 0 and keep looking for a number less than 9 to increment and terminate the loop
        index == major_segment ? version_segments[index] += 1 : version_segments[index] = 0
      else
        # when we find a number less than 9, we increment it and break the loop
        version_segments[index] += 1
        break
      end
    end

    # reverse back the version segments
    version_segments.reverse.join('.')
  end
end
