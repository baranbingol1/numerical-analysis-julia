function minor(A, row, col)
	# birden matrisin sonuna kadar git rowun olduğu yerleri çıkar
	# birden matrisin sonuna kadar git columun olduğu yerleri çıkar
	# böylece verilen satır ve sütunun olmadığı alt matrisi döndürür
	return A[setdiff(1:end, row), setdiff(1:end, col)]
end


function determinant(A)
	n = size(A, 1) # matris nxn lik olmalıdır

	# base case
	if n == 1
		return A[1,1]
	end
 
	det_A = 0

	# -1^(1+j) terimi işareti belirler
	# diğer kısımlar minor ile elemanın kendisini çarpmayı recursive olarak tekrarlar
	for j in 1:n
		det_A += (-1)^(1+j) * A[1,j] * determinant(minor(A, 1, j))
	end

	return det_A
end

# örnek test

B = [2 5; 1 6]
C = [1 2 3; 4 5 6; 7 8 9]
D = [1 2 3 4; 5 6 7 8; 9 10 11 12; 13 14 15 16]

det_B = determinant(B)
det_C = determinant(C)
det_D = determinant(D)

println("2x2lik B matrisinin determinantı: ", det_B) # 7
println("3x3lük C matrisinin determinantı: ", det_C) # 0
println("4x4lük D matrisinin determinantı: ", det_D) # 0


