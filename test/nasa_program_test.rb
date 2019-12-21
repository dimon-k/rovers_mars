require './lib/nasa_program'
require 'test/unit'

class NasaProgramTest < Test::Unit::TestCase
  def test_exercice_examples
    @nasa_program = NasaProgram.new(5, 5)

    @nasa_program.set_initial_position(1, 2, :N)
    result1 = @nasa_program.explore(:L, :M, :L, :M, :L, :M, :L, :M, :M)

    @nasa_program.set_initial_position(3, 3, :E)
    result2 = @nasa_program.explore(:M, :M, :R, :M, :M, :R, :M, :R, :R, :M)

    assert_equal(result1, [1, 3, :N])
    assert_equal(result2, [5, 1, :E])
  end

  def test_big_plateau_examples
    @nasa_program = NasaProgram.new(10, 10)

    @nasa_program.set_initial_position(6, 4, :S)
    result1 = @nasa_program.explore(:R, :R, :M, :L, :M, :R, :M, :M, :L, :M, :L, :M, :L, :M, :M, :M, :M, :M, :M)

    @nasa_program.set_initial_position(1, 1, :W)
    result2 = @nasa_program.explore(:M, :L, :M, :L, :M, :M, :L, :M, :R, :M, :R, :M, :R, :R)

    assert_equal(result1, [10, 6, :E])
    assert_equal(result2, [3, 0, :N])
  end

  def test_small_plateau_examples
    @nasa_program = NasaProgram.new(2, 2)

    @nasa_program.set_initial_position(2, 2, :E)
    result1 = @nasa_program.explore(:R, :M, :R, :M, :L)

    @nasa_program.set_initial_position(0, 1, :W)
    result2 = @nasa_program.explore(:L, :M, :L, :M, :M, :L, :M, :R)

    assert_equal(result1, [1, 1, :S])
    assert_equal(result2, [2, 1, :E])
  end

  def test_rectangular_hirizontal_plateau_examples
    @nasa_program = NasaProgram.new(4, 1)

    @nasa_program.set_initial_position(1, 0, :S)
    result1 = @nasa_program.explore(:L, :M, :L, :M, :R, :M, :R)

    @nasa_program.set_initial_position(1, 1, :N)
    result2 = @nasa_program.explore(:R, :R, :R, :M, :L, :M, :R)

    assert_equal(result1, [3, 1, :S])
    assert_equal(result2, [0, 0, :W])
  end

  def test_rectangular_vertical_plateau_examples
    @nasa_program = NasaProgram.new(2, 3)

    @nasa_program.set_initial_position(2, 1, :E)
    result1 = @nasa_program.explore(:R, :M, :R, :M, :R, :M, :M, :M, :L)

    @nasa_program.set_initial_position(2, 3, :W)
    result2 = @nasa_program.explore(:L, :M, :R, :M, :M, :L, :M, :L, :M)

    assert_equal(result1, [1, 3, :W])
    assert_equal(result2, [1, 1, :E])
  end

  def test_initial_coordinates_validation
    @nasa_program = NasaProgram.new(2, 2)
    
    exception = assert_raise(RuntimeError) { @nasa_program.set_initial_position(3, 2, :E) }
    assert_equal('X is out of range!', exception.message)

    exception = assert_raise(RuntimeError) { @nasa_program.set_initial_position(2, -1, :E) }
    assert_equal('Y is out of range!', exception.message)

    exception = assert_raise(RuntimeError) { @nasa_program.set_initial_position(2, 2, :G) }
    assert_equal('Improper direction!', exception.message)
  end

  def test_improper_moves_validation
    @nasa_program = NasaProgram.new(2, 2)
    @nasa_program.set_initial_position(2, 2, :E)

    exception = assert_raise(RuntimeError) { @nasa_program.explore(:R, :M, :L, :K) }
    assert_equal('Improper move!', exception.message)
  end
end
