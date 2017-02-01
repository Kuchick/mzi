require 'digest'

def encrypt(path, answer_path, password)
	md5 = Digest::MD5.new
	md5.update(password)
	key_array = md5.hexdigest.split('').map{|el| el.ord}

	File.open(path, 'r+') do |file|
		content = file.read
		byte_num_array = []
		cipher_num_array = []
		content.each_byte {|byte_num| byte_num_array << byte_num}
		array_of_blocks = byte_num_array.each_slice(32).to_a
		array_of_blocks.map!{|block| block.zip(key_array).map { |x, y| (x + y) % 256 }}
		string_answer = array_of_blocks.map!{|block| block.map{|elem| elem.chr}}.join

		# cipher_array = []
		# cipher_num_array.each {|elem| cipher_array << elem.chr}
		File.open(answer_path, 'w+') do |file2|
			file2.write(string_answer)
		end
	end

end


def decrypt(path, answer_path, password)
	md5 = Digest::MD5.new
	md5.update(password)
	key_array = md5.hexdigest.split('').map{|el| el.ord}

	File.open(path, 'r+') do |file|
		content = file.read
		byte_num_array = []
		cipher_num_array = []
		content.each_byte {|byte_num| byte_num_array << byte_num}

		array_of_blocks = byte_num_array.each_slice(32).to_a
		array_of_blocks.map!{|block| block.zip(key_array).map { |x, y| (x - y) % 256 }}
		string_answer = array_of_blocks.map!{|block| block.map{|elem| elem.chr}}.join


		# byte_num_array.each {|byte| cipher_num_array << (byte - password) % 256}
		# cipher_array = []
		# cipher_num_array.each {|elem| cipher_array << elem.chr}
		File.open(answer_path, 'w+') do |file2|
			file2.write(string_answer)
		end
	end
end

encrypt("1.file", "2.file", 'password')
decrypt("2.file", "3.file", 'password1')
