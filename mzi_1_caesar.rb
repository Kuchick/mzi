def encrypt(path, answer_path, password)
	File.open(path, 'r+') do |file|
		content = file.read
		byte_num_array = []
		cipher_num_array = []
		content.each_byte {|byte_num| byte_num_array << byte_num}
		byte_num_array.each {|byte| cipher_num_array << (byte + password) % 256}
		cipher_array = []
		cipher_num_array.each {|elem| cipher_array << elem.chr}
		#puts cipher_array.join[0..100]
		File.open(answer_path, 'w+') do |file2|
			file2.write(cipher_array.join)
		end
	end

end


def decrypt(path, answer_path, password)
	File.open(path, 'r+') do |file|
		content = file.read
		byte_num_array = []
		cipher_num_array = []
		content.each_byte {|byte_num| byte_num_array << byte_num}
		byte_num_array.each {|byte| cipher_num_array << (byte - password) % 256}
		cipher_array = []
		cipher_num_array.each {|elem| cipher_array << elem.chr}
		#puts cipher_array.join[0..100]
		File.open(answer_path, 'w+') do |file2|
			file2.write(cipher_array.join)
		end
	end
end

encrypt("1.file", "2.file", 100)
decrypt("2.file", "3.file", 100)
