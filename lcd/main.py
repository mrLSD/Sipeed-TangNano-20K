from PIL import Image    

image = Image.open('3.jpg')
print(image.size)
# 800x480
image.thumbnail((200, 250))
print(image.size)
image.save("2.jpg")

hex_values = []
# pixels = image.convert('RGB').getdata()
pixels = image.convert('RGB').getdata()
print("Pixels: ", len(pixels))

# x = 0
# y = 0
# for i, pixel in enumerate(pixels):
#     color = (0x00,0x00, 0x00)
#     if x < 50 or (x > 100 and x < 150):
#         color = (0xFF,0x00, 0x00)
#     pixels.putpixel((x, y), color)
#     if x < 269:
#         x += 1
#     else:
#         x = 0
#         y += 1

for pixel in pixels:
    r, g, b = pixel
    hex_value = "{:02x}{:02x}{:02x}".format(r, g, b)
    # hex_value = "00ff00"
    hex_values.append(hex_value)

with open('output.hex', 'w') as f:
    for hex_value in hex_values:
        f.write(hex_value + ' ')
