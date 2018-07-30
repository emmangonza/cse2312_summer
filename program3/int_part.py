#counting integer partitions for testing

#recursive funtion to do all of the work
def count_partitions(n, m) :
	if n == 0 :
		return 1
	elif n < 0 :
		return 0
	elif m == 0 :
		return 0
	else :
		return count_partitions(n - m, m) + count_partitions(n, m - 1)

#main
n = 0
m = 0

while n != -1 or m != -1 :
	n_str = input("n = ")
	m_str = input("m = ")

	n = int(n_str)
	m = int(m_str)

	x = count_partitions(n, m)

	print("There are {:d} partitions of {:d} using integers up to {:d}" .format(x, n, m))
