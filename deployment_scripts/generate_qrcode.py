import qrcode

def main(): 
    url = "www.google.com"
    img = qrcode.make(rf"https://{url}")
    return img
    # img.save(f"qrcode_{url}.png")
main()