class NasaProgram
  def initialize(x_max, y_max)
    @x_max         = x_max
    @y_max         = y_max
    @width         = @x_max + 1
    @compas        = [:N, :E, :S, :W]
    @weights       = { N: @width, E: 1, S:  -@width, W: -1}
    @working_scale = (@x_max + 1) * (@y_max + 1)
  end

  def set_initial_position(x_initial, y_initial, direction)
    validate_initial_coordinates(x_initial, y_initial, direction)

    @move_around     = y_initial * @width + x_initial
    @compas_position = @compas.index(direction)
    @current_weight  = @weights[direction]
  end

  def explore(*move_sequence)
    @move_sequence = move_sequence
    @move_sequence.each { |move| execute_move(move) }
    [@move_around % @width, @move_around / @width, @compas[@compas_position]]
  end

  private

  def validate_initial_coordinates(x_initial, y_initial, direction)
    raise 'X is out of range!'  unless x_initial.between?(0, @x_max)
    raise 'Y is out of range!'  unless y_initial.between?(0, @y_max)
    raise 'Improper direction!' unless @compas.include?(direction)
  end

  def execute_move(move)
    return turn_left     if move.eql?(:L)
    return turn_right    if move.eql?(:R)
    return move_forward  if move.eql?(:M)

    raise 'Improper move!'
  end

  def turn_left
    @compas.unshift(@compas.last).pop()
    set_current_weight
  end

  def turn_right
    @compas.push(@compas.first).shift()
    set_current_weight
  end

  def set_current_weight
    @current_weight = @weights[@compas[@compas_position]]
  end

  def move_forward
    validate_plateau_borders
    @move_around += @current_weight
  end

  def validate_plateau_borders
    x, y = @move_around % @width, @move_around / @width
    out_message = -> (direction) { raise "Rover out of plateau to the #{direction}!" }

    out_message.call('north') if @current_weight.eql?(@width)  && y.eql?(@y_max)
    out_message.call('east')  if @current_weight.eql?(1)       && x.eql?(@x_max)
    out_message.call('south') if @current_weight.eql?(-@width) && y.zero?
    out_message.call('west')  if @current_weight.eql?(-1)      && x.zero?
  end
end
