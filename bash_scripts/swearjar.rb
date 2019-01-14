TEXT_LETTERS = {
  A: [' ### ', '#   #', '#####', '#   #', '#   #'],
  B: ['#### ', '#   #', '#### ', '#   #', '#### '],
  C: [' ### ', '#   #', '#    ', '#   #', ' ### '],
  D: ['#### ', '#   #', '#   #', '#   #', '#### '],
  E: ['#####', '#    ', '###  ', '#    ', '#####'],
  F: ['#####', '#    ', '###  ', '#    ', '#    '],
  G: [' ### ', '#    ', '#  ##', '#   #', ' ### '],
  H: ['#   #', '#   #', '#####', '#   #', '#   #'],
  I: ['#####', '  #  ', '  #  ', '  #  ', '#####'],
  J: ['    #', '    #', '    #', '#   #', ' ### '],
  K: ['#   #', '#  # ', '###  ', '#  # ', '#   #'],
  L: ['#    ', '#    ', '#    ', '#    ', '#####'],
  M: ['#   #', '## ##', '# # #', '#   #', '#   #'],
  N: ['#   #', '##  #', '# # #', '#  ##', '#   #'],
  O: [' ### ', '#   #', '#   #', '#   #', ' ### '],
  P: ['#### ', '#   #', '#### ', '#    ', '#    '],
  Q: [' ### ', '#   #', '#   #', '#  # ', ' ## #'],
  R: ['#### ', '#   #', '#### ', '#  # ', '#   #'],
  S: ['#####', '#    ', '#####', '    #', '#####'],
  T: ['#####', '  #  ', '  #  ', '  #  ', '  #  '],
  U: ['#   #', '#   #', '#   #', '#   #', ' ### '],
  V: ['#   #', '#   #', '#   #', ' # # ', '  #  '],
  W: ['#   #', '#   #', '#   #', '# # #', ' # # '],
  X: ['#   #', ' # # ', '  #  ', ' # # ', '#   #'],
  Y: ['#   #', ' # # ', '  #  ', '  #  ', '  #  '],
  Z: ['#####', '   # ', '  #  ', ' #   ', '#####']
}.freeze

TEXT_COLORS = {
  red: "\e[31m",
  green: "\e[32m",
  yellow: "\e[33m",
  blue: "\e[34m",
  magenta: "\e[35m",
  cyan: "\e[36m",
  white: "\e[37m",
  default: "\e[39m"
}.freeze

# Represents a large letter and associated color
class Letter
  attr_reader :chars, :color
  def initialize(let)
    @chars = TEXT_LETTERS[let.to_sym.upcase]
    @color = TEXT_COLORS[TEXT_COLORS.keys.sample]
  end

  def line(idx)
    return '' if idx < 0 || idx > 4
    "#{color} #{chars[idx]}"
  end
end

words = []

ARGV.each do |a|
  letters = a.split ''
  words << [].tap do |w|
    letters.each { |l| w << Letter.new(l) }
  end
end

str = "\n"

(0..4).each do |i|
  words.each do |w|
    w.each { |l| str << "#{l.line i}   " }
    str << '     '
  end
  str << "\n"
end

puts "#{str}\n"
