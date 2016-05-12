require 'mathn.rb'

def f(x)
	x**2 + Math::log10(x + 2)
end

def f_10(x)
	-362880/(x + 2)**10
end

$a = 0.5
$b = 1.0
x1 = 0.53
x2 = 0.52
x3 = 0.97
x4 = 0.73
$h = ($b - $a)/10
$xi = Array.new(11){|i| $a + i * $h}
$fi = Array.new(11) {|i| f($xi[i])}

class Array
	#Cумма
	def sum()
		a = 0
		for i in (0...self.length)
			a += self[i]
		end
		a
	end

	#Произведение
	def pr()
		a = 1
		for i in (0...self.length)
			a *= self[i]
		end
		a
	end
end

#Конечная разность
def f_i(k, i)
	if (k == 0)
		return $fi[i]
	end
	(f_i(k - 1, i) - f_i(k - 1, i - 1))
end

#Факториал
def fact(n)
	if (n == 0)
		return 1
	end
	fact(n - 1) * n
end

#формальный t!/(t - k)!
def fact_t(t, k)
	if (k == 0)
		return t
	end
	if (k < 0)
		return 1
	end
	(t - k) * fact_t(t, k - 1)
end

#погрешность
def R(fnk, x, k)
	a = Array.new(11) {|i| x - $xi[i]}
	# p a
	(fnk * a.pr / fact(k)).abs
end

#формула Ньютона
def L_n(x)
	t = (x - $a) / $h
	a = Array.new(11){|i| f_i(i, i) * fact_t(t, i - 1) / fact(i)}
	a.sum()
end

puts "R: #{L_n(x1) - f(x1)}"
puts "R_min: #{R(f_10($a), x1, 10)}"
puts "R_max: #{R(f_10($b), x1, 10)}"
puts "R: #{L_n(x2) - f(x2)}"
puts "R_min: #{R(f_10($a), x2, 10)}"
puts "R_max: #{R(f_10($b), x2, 10)}"
puts "R: #{L_n(x3) - f(x3)}"
puts "R_min: #{R(f_10($a), x3, 10)}"
puts "R_max: #{R(f_10($b), x3, 10)}"
puts "R: #{L_n(x4) - f(x4)}"
puts "R_min: #{R(f_10($a), x4, 10)}"
puts "R_max: #{R(f_10($b), x4, 10)}"
