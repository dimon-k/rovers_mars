require './lib/nasa_program'
require 'test/unit'

class NasaProgramTest < Test::Unit::TestCase
  def test_exercice_examples
    @nasa_program = NasaProgram.new(5,5)

    @nasa_program.set_initial_position(1, 2, :N)
    result1 = @nasa_program.explore(:L, :M, :L, :M, :L, :M, :L, :M, :M)

    @nasa_program.set_initial_position(3, 3, :E)
    result2 = @nasa_program.explore(:M, :M, :R, :M, :M, :R, :M, :R, :R, :M)

    assert_equal(result1, [1, 3, :N])
    assert_equal(result2, [5, 1, :E])
  end
end
