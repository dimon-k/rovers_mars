class NasaProgram
  def initialize(*plateau)
    raise 'Dim to fix to allow rectangular areas!!!' if plateau[0] != plateau[1]
    raise 'Dim to fix: no more than 2x argumens'     if plateau.count != 2
    @plateau       = plateau
    @width         = @plateau[0] + 1
    @compas        = [:N, :E, :S, :W]
    @weights       = { N: @width, E: 1, S:  -@width, W: -1}
    @working_scale = (@plateau[0] + 1) * (@plateau[1] + 1)
  end

  def set_initial_position(*coordinates)
    @coordinates     = coordinates
    @move_around     = @coordinates[1] * @width + @coordinates[0]
    @compas_position = @compas.index(@coordinates[2])
    @current_weight  = @weights[@coordinates[2]]
  end

  def explore(*move_sequence)
    @move_sequence = move_sequence
    @move_sequence.each { |move| execute_move(move) }
    [@move_around % @width, @move_around / @width, @compas[@compas_position]]
  end

  private

  def execute_move(move)
    return turn_left     if move.eql?(:L)
    return turn_right    if move.eql?(:R)
    return move_forward  if move.eql?(:M)

    raise 'Improper value passed!'
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
    @move_around += @current_weight

    raise 'Out of plateau!!!' unless (0..@working_scale).include?(@move_around)
  end
end
