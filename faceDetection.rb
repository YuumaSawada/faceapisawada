require 'net/http'
require 'json'

imageUri = "";


puts "Please enter ImageURL"
while imageUri = gets

  imageUri = imageUri.chomp
# You must use the same location in your REST call as you used to get your
# subscription keys. For example, if you got your subscription keys from  westus,
# replace "westcentralus" in the URL below with "westus".
uri = URI('https://westus2.api.cognitive.microsoft.com/face/v1.0/detect')
uri.query = URI.encode_www_form({
    # Request parameters
    #'returnFaceId' => 'true',
    'returnFaceLandmarks' => 'false',
    'returnFaceAttributes' => 'age,gender,smile,emotion'
})

request = Net::HTTP::Post.new(uri.request_uri)
# Request headers
# Replace <Subscription Key> with your valid subscription key.
request['Ocp-Apim-Subscription-Key'] = '7f9c7d18970b4226a6e22ad2d2a5ef71'
request['Content-Type'] = 'application/json'

#imageUri = "https://upload.wikimedia.org/wikipedia/commons/3/37/Dagestani_man_and_woman.jpg"

request.body = "{\"url\": \"" + imageUri + "\"}"

response = Net::HTTP.start(uri.host, uri.port, :use_ssl => uri.scheme == 'https') do |http|
    http.request(request)
end

$test = response.body

$test = JSON.parse($test)
$i = 0
puts"------------------------------------------"
$test.each do |test|
  $i+=1
  puts "#{$i}人目"
  puts "年齢:#{test["faceAttributes"]["age"].floor}歳"
  if test["faceAttributes"]["gender"].eql?("female")
    puts "性別:女性"
  else
    puts "性別:男性"
  end

  if test["faceAttributes"]["smile"] <= 0.5
    puts "全然笑顔じゃないですよ！！！"
    puts "笑って！！！"
  else
    puts "いい笑顔！！！！！！！！"
    puts "Nice Smile!!!!!"
  end
  puts"------------------------------------------"
end

#puts "画像アドレス:#{imageUri}"

#puts "-------------------------------------------"
puts
puts
puts
puts

puts "Please enter ImageURL"

end
