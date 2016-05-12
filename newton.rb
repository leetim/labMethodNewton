require 'mathn.rb'

def f(x)
	x**2 + Math::log10(x + 2)
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
	def sum()
		a = 0
		for i in (0...self.length)
			a += self[i]
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

#формула Ньютона
def L_n(x)
	t = (x - $a) / $h
	a = Array.new(11){|i| f_i(i, i) * fact_t(t, i - 1) / fact(i)}
	a.sum()
end

p $xi
p $fi 

p L_n(x1) - f(x1)
p L_n(x2) - f(x2)
p L_n(x3) - f(x3)
p L_n(x4) - f(x4)
