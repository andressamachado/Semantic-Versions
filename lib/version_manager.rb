# frozen_string_literal: true

##
# Class to represent a version numbering calculator
# Enables to create an object to perform calculations on a String holding a sequence of numbers separated
# by dots, representing a version number.
# Example:
#   version_manager = VersionManager.new
#   version_manager.next_version('1.2.3') # => '1.2.4'
#   version_manager.next_version('9.9.9') # => '10.0.0'
class VersionManager
  def initialize; end

  ##
  # Method to process the next version number based on the current version number given by the user
  # @param [String] current_version - The current version number
  # @return [String] updated_version - The next version number
  def next_version(current_version)
     # Transform from string to array of integers
     partials = current_version.split('.').map(&:to_i)

     # Going back from end to start of array
     (partials.length - 1).downto(0) do |index|
       # increment if its 9 by setting to 0, and continue to next number
       if partials[index] == 9
         # if it is the major element of the version, we increase regardeless the current number
         index == 0 ? partials[index] += 1 : partials[index] = 0
       else
         # if its less than 9, we increment and stop the loop, since we dont carry over any amount in this case
         partials[index] +=  1
         break
       end
     end

     # Builds the string version again and return
     updated_version = partials.join('.')
  end
end

version_manager = VersionManager.new
puts version_manager.next_version('9.9.9') # => '10.0.0'
puts version_manager.next_version('1.2.3') # => '1.2.4'
